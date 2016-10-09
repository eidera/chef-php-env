current_dir = File.absolute_path( File.dirname(__FILE__) )
cookbook_path [ "#{current_dir}/site-cookbooks" ]
role_path "#{current_dir}/roles"
