
BEGIN { FS=","; OFS="";
print "Starting creating configurations";
sip_server = "http://192.168.5.102/";
account_name = "FreePBX server";
path = "configurations/";
}

NR > 1 {
	# file= cfgMAC.xml
	file="cfg"$2".xml";
	fullpath=path""file;
	result = "";
	i = 0;
	output[0] = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>";
	output[1] = "<gs_provision version=\"1\">";
	output[2] = "<mac>"$2"</mac>";
	output[3] = "<config version=\"1\">";
	output[4] = "<P271>1</P271>";  # Account Active. 0 - No, 1 - Yes. 
	output[5] = "<P270>"$1"</P270>";  # Account Name
	output[6] = "<P47>"sip_server"</P47>";  # SIP Server
	output[7] = "<P35>"$1"</P35>";  # SIP User ID
	output[8] = "<P36>"$1"</P36>";  # Authenticate ID
	output[9] = "<P34>"$1"</P34>";  # Authenticate Password
	output[10] = "<P3>"$1"</P3>";  # Authenticate Password

	output[11] = "<P103>"$1"</P103>";  # DNS Mode. 0 - A Record, 1 - SRV, 2 - NAPTR/SRV, 3 - Use Configured IP. Default is 0
	output[12] = "</config>";
	output[13] = "</gs_provision>";




	res = join(output,0,length(output),"\n", result, i);
	print res > fullpath;
	delete output;
}

END {

print "Finish creating configurations";
}


# join.awk --- join an array into a string
# https://www.gnu.org/software/gawk/manual/html_node/Join-Function.html
function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}