# coding: utf-8
class CreateApressVideos < ActiveRecord::Migration
  def self.up
    execute "CREATE TYPE videos_subject_types AS ENUM ();"

    create_table :videos do |t|
      t.integer :subject_id, null: false
      t.column :subject_type, 'videos_subject_types', null: false
      t.string :url, null: false
      t.string :oembed_data, limit: 4000
      t.integer :position, null: false, default: 0
      t.belongs_to :provider, null: false
      t.timestamps
    end

    execute <<-SQL
      COMMENT ON TABLE public.videos IS 'Приложенное видео';
      COMMENT ON COLUMN public.videos.subject_id IS 'Идентификатор сущности, к которой приложено видео';
      COMMENT ON COLUMN public.videos.subject_type IS 'Тип сущности, к которой приложено видео ("Отзыв","Товар", etc)';
      COMMENT ON COLUMN public.videos.url IS 'Введенный пользователем URL видео';
      COMMENT ON COLUMN public.videos.oembed_data IS 'Полученный от провайдера видео oembed';
      COMMENT ON COLUMN public.videos.provider_id IS 'Провайдер для видео';
    SQL

    execute <<-SQL.strip_heredoc
      ALTER TABLE videos
      ADD CONSTRAINT subject_type_subject_id_position
      UNIQUE (subject_type, subject_id, position) DEFERRABLE INITIALLY DEFERRED;
    SQL
  end

  def self.down
    drop_table :videos
    execute 'DROP TYPE videos_subject_types;'
  end
end