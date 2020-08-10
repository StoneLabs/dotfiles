################
################

FILE=/tmp/screenshot_$$.jpg

################
################

ffplay -f lavfi -i 'sine=frequency=600:duration=0.05' -autoexit -nodisp; 
ffplay -f lavfi -i 'sine=frequency=600:duration=0.05' -autoexit -nodisp; 

scrot -s $FILE; 
imgurbash2 $FILE; 
rm $FILE; 

ffplay -f lavfi -i 'sine=frequency=700:duration=0.05' -autoexit -nodisp; 
ffplay -f lavfi -i 'sine=frequency=700:duration=0.05' -autoexit -nodisp; 
ffplay -f lavfi -i 'sine=frequency=700:duration=0.05' -autoexit -nodisp; 
ffplay -f lavfi -i 'sine=frequency=1200:duration=0.1' -autoexit -nodisp; 
