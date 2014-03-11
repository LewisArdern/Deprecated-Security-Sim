def create_solution(system_xml, base_xml, vulns_xml,network_xml)

    known_boxes = list_known_base_boxes(system_xml, base_xml)
    known_vulns = list_known_vulnerabilities(vulns_xml,system_xml)
    known_networks = list_there_known_networks(network_xml,system_xml)
    #create_vagrant_file(known_boxes,known_vulns,known_networks) 
end

def list_known_base_boxes(system_xml, base_xml)
  boxes_with_known_bases = []

  system_xml.each { |s|
    base_xml.each { |b|
      if b[:base] == s[:base] 
        boxes_with_known_bases << s
      break
    end
    }
  }
  return boxes_with_known_bases
end

def list_known_vulnerabilities(vulns_xml,system_xml)
  boxes_with_known_vulnerabilities = []
  
  vulns_xml.each { |v|
    system_xml.each { |s|
      if v[:vulnerability] == s[:vulnerability] 
        boxes_with_known_vulnerabilities << s
      break
    end
    }
  }
  return boxes_with_known_vulnerabilities
end

def list_there_known_networks(network_xml,system_xml)
  boxes_with_known_networks = []
  
  network_xml.each { |n|
    system_xml.each { |s|

      
      if s[:network].include?(n[:name])
        puts 'test'
        boxes_with_known_networks << s
      break
    end
    }
  }
  return boxes_with_known_networks
end

# def create_solution(system_xml, base_xml, vulns_xml)

#   bases = []
  
#   puts system
#   system_xml.each { |s|
#     bases[s.number] = []
#     base_xml.each { |b|
#         bases[s.number][0] = []
#         bases[s.number][1] = []
#       if s.base == b.base
#         bases[s.number][0] << b
#       break
#       else 
#         bases[s.number][1] << s
#      end
#     }
#   }
# end