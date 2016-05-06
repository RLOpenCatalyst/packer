FROM mateens001/rlcatalyst:latest
ADD start_script.sh /start_script.sh
ENTRYPOINT ["/start_script.sh"]

