=begin

  Setup a custom database for KissMetrics tracking events.

=end

require 'active_record'

module KMDB
  class SetupEventsDatabase < ActiveRecord::Migration
    def self.connection
      CustomRecord.connection
    end

    def self.up

      create_table :events do |t|
        t.integer  :user_id
        t.integer  :n
        t.datetime :t
      end
      add_index :events, [:n]
      add_index :events, [:user_id]


      create_table :keys do |t|
        t.string :string
      end
      add_index :keys, [:string]

      create_table :properties do |t|
        t.integer  :user_id
        t.integer  :event_id
        t.integer  :key
        t.string   :value
        t.datetime :t
      end
      add_index :properties, [:key]
      add_index :properties, [:user_id]
      add_index :properties, [:event_id]

      create_table :users do |t|
        t.string  :name
        t.integer :alias_id
      end
      add_index :users, [:name]

      create_table :dumpfiles do |t|
        t.string  :path
        t.string  :job
        t.integer :offset
      end
      add_index :dumpfiles, [:path]

    end

    def self.down
      drop_table :events
      drop_table :keys
      drop_table :properties
      drop_table :users
      drop_table :dumpfiles
    end
  end
end
