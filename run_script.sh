cp demo.crt /tmp/docker

./adguard -l 0.0.0.0 -p 8118\
          -c demo.crt\
          -k demo.key\
          -f adguard_base.txt\
          -f adguard_tracking_protection.txt\
          -f adguard_social.txt