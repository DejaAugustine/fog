Shindo.tests('Fog::Rackspace::Databases | user', ['rackspace']) do

  pending if Fog.mocking?

  service = Fog::Rackspace::Databases.new
  instance = service.instances.create({
                                        :name => "fog_instance_#{Time.now.to_i}",
    :flavor_id => 1,
    :volume_size => 1
  })

  instance.wait_for { ready? }

  options = {
    :name => "user_#{Time.now.to_i}",
    :password => "fog_user"
  }
  model_tests(instance.users, options, false)

  instance.destroy
end
