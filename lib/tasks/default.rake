namespace "load:default" do 
    desc "Load participating school codes for year 2013"
    task :codes => :environment do
        codes = Array.new

        codes << Codes.new(:code => 'UPVTC2013001', :owner => 'UPVTC', :description => 'Code for UPVTC year 2013' )
        codes << Codes.new(:code => 'LNU2013002', :owner => 'LNU', :description => 'Code for LNU year 2013' )
        codes << Codes.new(:code => 'EVSU2013003', :owner => 'EVSU', :description => 'Code for EVSU year 2013' )
        codes << Codes.new(:code => 'ACLC2013004', :owner => 'ACLC', :description => 'Code for ACLC year 2013' )
        codes << Codes.new(:code => 'AMA2013005', :owner => 'AMA', :description => 'Code for AMA year 2013' )
        codes << Codes.new(:code => 'STI2013006', :owner => 'STI', :description => 'Code for STI year 2013' )
        codes << Codes.new(:code => 'SPC2013007', :owner => 'SPC', :description => 'Code for SPC year 2013' )
        codes << Codes.new(:code => 'SJC2013008', :owner => 'SJC', :description => 'Code for SJC year 2013' )
        codes << Codes.new(:code => 'VSU2013009', :owner => 'VSU', :description => 'Code for VSU year 2013' )
        codes << Codes.new(:code => 'SSU2013010', :owner => 'SSU', :description => 'Code for SSU year 2013' )
        codes << Codes.new(:code => 'SLSU2013011', :owner => 'SLSU', :description => 'Code for SLSU year 2013' )
        codes << Codes.new(:code => 'NSU2013012', :owner => 'NSU', :description => 'Code for NSU year 2013' )
        codes << Codes.new(:code => 'ESSU2013013', :owner => 'ESSU', :description => 'Code for ESSU year 2013' )
        codes << Codes.new(:code => 'EVSUOrmoc2013014', :owner => 'EVSU-Ormoc', :description => 'Code for EVSU-Ormoc year 2013' )

        Codes.import codes
    end

    desc "Load workshops for year 2013"
    task :workshops => :environment do
        workshops = Array.new

        workshops << Workshops.new(:title => "HTML and CSS",:description=>"Basic HTML and CSS",:facilatators=>"Nick Aguilos", :year=>2013)
        workshops << Workshops.new(:title => "Jquery",:description=>"Basic Jquery",:facilatators=>"Yan Barreta", :year=>2013)
        workshops << Workshops.new(:title => "Web Development",:description=>"Basic of Web Development: Using Php",:facilatators=>"Czar Pino", :year=>2013)
        workshops << Workshops.new(:title => "Version Control",:description=>"Code integration: Basic Git and Svn",:facilatators=>"Farly Taboada", :year=>2013)

        Workshops.import workshops
    end
    
end