Category.destroy_all
categories_attributes = %w{ Education Fashion Food Waste Health Environment Inclusion Community }
p "Creating seeds"
categories_attributes.each { |params| Category.create(name: params) }
p "Done !"



# These seeds have vital information

# Organization.find_or_create_by(name:"The Inclusion Factory"){|c| c.assign_attributes({address:"Taican, China",
#                                                                                       photos: "inclusionfactory.png",
#                                                                                       website: "www.inclusion-factory.com",
#                                                                                       problem: "Providing Mentally challeged and handicap individuals with employment",
#                                                                                       description: "Mission: The Inclusion factory is the first Industrial workshop in China to provide meaningful employment to people with intellectual and mental disabilities."})}.save
# Organization.find_or_create_by(name:"Shangri La Farms"){|c| c.assign_attributes({address:"Beijing, China",
#                                                                                  photos: "shangrilafarms.png",
#                                                                                  website: "http://www.shangrilafarms.com",
#                                                                                  problem: "Educating people and building a fair trade farming network",
#                                                                                  description: "Shangrila Farms creates lasting social change in remote rural communities by supporting farmers who grow pesticide-free crops with income premiums added for quality, and green growing practices."})}.save
# Organization.find_or_create_by(name:"First Respond"){|c| c.assign_attributes({address:"Tibet",
#                                                                               photos: "firstrespond.png",
#                                                                               website: "https://www.sos919.com/",
#                                                                               problem: "Developed free first-aid training, services,and solutions course for Tibetan locals.",
#                                                                               description: "First Respond 第一反应® dedicate to delivering high-quality first aid training, services and solutions to individuals and businesses in China. Our mission is to create a society of citizen first responders with an integrated SOS system so that people suffering from an emergency can be saved, with the eventual hope of establishing “mutual aid” as a new Chinese social norm."})}.save
# Organization.find_or_create_by(name:"Zero Waste Shanghai"){|c| c.assign_attributes({address:"Shangai",
#                                                                                     photos: "zerowaste.png",
#                                                                                     website: "http://www.zerowasteshanghai.com/",
#                                                                                     problem: "Promote a zero waste lifestyle to educate people about waste",
#                                                                                     description: "Zero Waste China was created in 2016 as a community platform for people to adopt a more sustainable lifestyle in Shanghai. As the organization is moving more towards a social enterprise model, they aim to make a zero waste life accessible, simple, and practical for eco-conscious individuals and organizations."})}.save
