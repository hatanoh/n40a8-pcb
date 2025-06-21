BEGIN {
	OFS=","
	pi=3.1415926535

	# parts offset
	offset["CPG151101S11-16"]="-0.635,3.81,0"
	offset["SSAJ120100"]="0,-0.65,0"
	offset["SSAJ110100"]="0,-0.65,0"
	offset["TPS61221"]="0,0,90"

	offset["SSSS811101"]="0,-0.45,0"
	offset["SKTDLDE010"]="0,0.75,0"
	
	# header
	print "Designator,Mid X,Mid Y,Rotation,Layer"
}

{
	x=$4+0
	y=$5+0
	r=$6+0
	for (parts in offset) {
		if ( $2 == parts ) {
			split(offset[parts], param, ",")
			oX=param[1]
			oY=param[2]
			oR=param[3]

			s=r*pi/180
			x+=oX*cos(s)-oY*sin(s)
			y+=oX*sin(s)+oY*cos(s)
			r+=oR
		}
	}
	if ($0 !~ /^#/) {
		r=(-r+180)%360
		print $1,x,y,r,$7
	}
}

