# Monitor repository
Setup incomming ftp accounts for security cameras. Use a admin account to view all cameras and the 7 day archive.

All recordings are rotated on a 7 day schedule.

### Setup Container
`docker run -d --name monrep -p 21:21 -p 30000-30009:30000-30009 -e "PUBLICHOST=<external IP>" dhogborg/monrep`

### Check admin account
Connect with FTP on port 21. Use the account details from stdout log on container. `docker logs monrep`

### Add a camera
`docker exec -ti monrep addcam <camera name>`
Enter a password for the camera and repeat it to confirm.