def sendNotification(message)
	str = "curl http://api.airgramapp.com/1/send_as_guest \\\n --data-urlencode email='yash0609@gmail.com' \\\n --data-urlencode msg='#{message}'"
	system(str)
end


print "Number of Parts = "
number_of_videos = gets.to_i * 12

print "Name of Directory? "
directory_name = gets.to_s.gsub("\n", "")

print "Starting Lecture? (1 for beginning) "
beginning_lecture = gets.to_i

new_dir_command = "mkdir #{directory_name}"
system(new_dir_command)

for lecture_number in (beginning_lecture..number_of_videos)
	videos_per_disc = 6
	track_number_to_rip = ((lecture_number % videos_per_disc == 0) ? 6 : lecture_number % videos_per_disc) + 1
	rip_command = "./HandBrakeCLI -i /dev/disk1 --preset=\"Normal\" -t #{track_number_to_rip} --deinterlace=\"fast\" -o #{directory_name}" + "/#{lecture_number}.mp4"
	system(rip_command);
	if((lecture_number % videos_per_disc == 0) && lecture_number != number_of_videos)
		sendNotification("Laptop: New Disc Needed");
		print "Put in new disc. "
		`drutil eject`
		gets
	end
end
