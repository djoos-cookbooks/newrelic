#
# Cookbook Name:: newrelic
# Library:: default
#
# Copyright 2012-2014, Escape Studios
#

class Chef
  # Recipe Helpers
  class Recipe
    def get_newrelic_license(type)
      if node['newrelic']['use_vault']
        include_recipe 'chef-vault'
        chef_vault_item(node['newrelic']['data_bag'], node['newrelic']['data_bag_item'])[type]
      else
        node['newrelic'][type]['license']
      end
    end
  end
end
