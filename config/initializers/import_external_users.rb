if defined?(Rails::Server)
  Rails.application.config.after_initialize do
    begin
      if ImportExternalUsers.is_users_sync?
        Rails.logger.info '[IEU] => External users is sync. Skipping import of external users.'
      else
        Rails.logger.info '[IEU] => External users is not sync. Starting to import external users.'
        ImportExternalUsers.import_artist_and_relations
      end
    rescue StandardError => e
      Rails.logger.error "[IEU] => Failed to import external users: #{e.message}"
    end
  end
end