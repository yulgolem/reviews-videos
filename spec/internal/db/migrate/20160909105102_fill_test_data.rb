class FillTestData < ActiveRecord::Migration
  def up
    execute 'COMMIT;'

    execute "ALTER TYPE videos_subject_types ADD VALUE 'Subject';"
  end

  def down
  end
end
