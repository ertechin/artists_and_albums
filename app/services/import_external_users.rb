class ImportExternalUsers
  USER_INFO_BASE_URL = ENV['IMPORT_EXTERNAL_USERS_INFO_BASE_URL']
  USER_PHOTO_BASE_URL = ENV['IMPORT_EXTERNAL_USERS_PHOTO_BASE_URL']
  private_constant :USER_INFO_BASE_URL, :USER_PHOTO_BASE_URL

  class << self
    def import_artist_and_relations
      if check_servers_availability
        begin
          create_users
          process_all_users_with(:add_photo)
          process_all_users_with(:create_albums)
        rescue => e
          Rails.logger.error "[IEU] => Error during import: #{e.message}"
        end
      else
        Rails.logger.warn '[IEU] => Server is down, skipping import of external users.'
      end
    end

    def is_users_sync?
      # this is a dummy method
      User.any? ? true : false
    end

    private

    def get_users
      response = get_request_to(USER_INFO_BASE_URL, 'users')
      if response.success?
        JSON.parse(response.body)
      else
        Rails.logger.error "[IEU] => #{USER_INFO_BASE_URL} response failed. #{response.status}"
      end
    end

    def create_users
      get_users.each do |user|
        begin
          User.create!(user_data(user))
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "[IEU] => Failed to create user with id #{user['id']}: #{e.message}"
        end
      end
    end

    def user_data(user)
      {
        external_id: user['id'], name: user['name'], email: user['email'],
        user_name: user['username'], phone: user['phone'],
        other_infos: user.slice('address', 'website', 'company')
      }
    end

    def process_all_users_with(method)
      User.find_each { |user| ImportExternalUsers.send(method, user) }
    end

    def add_photo(user)
      response = get_request_to(USER_PHOTO_BASE_URL, 'id', user.external_id, 'info')
      user_photo_info = JSON.parse(response.body)
      user.other_infos['photo'] = user_photo_info['download_url']
      user.save!
    rescue StandardError => e
      Rails.logger.error "[IEU] => An error occurred for user with id #{user.id}: #{e.message}"
    end

    def create_albums(user)
      response = get_request_to(USER_INFO_BASE_URL, 'albums')
      albums = JSON.parse(response.body)
      user_albums = albums.select { |album| album["userId"] == user.external_id }
      user_albums.each do |album|
        user.albums.create!(
          external_id: album['id'],
          title: album['title']
        )
      end
    end

    def check_servers_availability
      # USER_PHOTO_BASE_URL && USER_INFO_BASE_URL is available
      true
    end

    def get_request_to(base_url, *path_parts)
      connection(generate_url(base_url, path_parts)).get
    end

    def connection(url)
      Faraday.new( url: , headers: {'Content-Type' => 'application/json'} )
    end

    def generate_url(base_url, *path_parts)
      base_url + '/' + path_parts.join('/')
    end
  end
end