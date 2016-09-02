# dperilla/docker-asterisk

dperilla/docker-asterisk is a docker base image that bundles the latest version of asterisk certified version with pjsip.
What is Asterisk?

Asterisk is a free and open source framework for building communications applications and is sponsored by Digium.
Asterisk turns an ordinary computer into a communications server. Asterisk powers IP PBX systems, VoIP gateways, conference servers and is used by small businesses, large businesses, call centers, carriers and governments worldwide.
Usage

# Run the following command:

docker run -d --name my-asterisk quaipsolutions/asterisk

# Enter the asterisk console:

docker exec -it my-asterisk rasterisk -vvvv

Asterisk 13.8-cert1, Copyright (C) 1999 - 2014, Digium, Inc. and others. 
Created by Mark Spencer <markster@digium.com>
Asterisk comes with ABSOLUTELY NO WARRANTY; type 'core show warranty' for details.
This is free software, with components licensed under the GNU General Public  
License version 2 and other licenses; you are welcome to redistribute it under
certain conditions. Type 'core show license' for details.

Connected to Asterisk 13.8-cert1 currently running on c28b7896d2d6 (pid = 1)
c28b7896d2d6*CLI>

