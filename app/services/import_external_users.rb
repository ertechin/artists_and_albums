class ImportExternalUsers
  USER_INFO_BASE_URL = ENV['IMPORT_EXTERNAL_USERS_INFO_BASE_URL']
  USER_PHOTO_BASE_URL = ENV['IMPORT_EXTERNAL_USERS_PHOTO_BASE_URL']
  private_constant :USER_INFO_BASE_URL, :USER_PHOTO_BASE_URL

  class << self
    def import_artist_and_relations
      if check_servers_availability
        create_users
      else
        Rails.logger.warn '[IEU] => Server is down, skipping import of external users.'
      end
    end

    def is_users_sync?
      true
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
      users = get_users
      users.each do |user|
        begin
          User.create!(
            external_id: user['id'],
            name: user['name'],
            email: user['email'],
            user_name: user['username'],
            phone: user['phone'],
            other_infos: user.slice('address', 'website', 'company')
          )
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "[IEU] => Failed to create user with id #{user['id']}: #{e.message}"
        end
      end
    end

    def cretae_users_releations; end

    def check_servers_availability
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