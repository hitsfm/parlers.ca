#!C:\perl\bin\perl.exe
### Set these variables

$chmod = 644;	# Permissions on uploaded file
$dircommand = 'ls -l';
# nooverwrites will prevent an upload from overwriting a file
# with the same name at the destination
$nooverwrites = 1;
# imagesonly will prevent uploading a file that does not have
# a ,gif or .jpg extension - you can add more extensions in the code
$imagesonly = 1;

# text for top of user pages
$baseurl = "http://parlers.ca/index.html";
$logourl = "http://parlers.ca/images/logo.gif";
$cgiurl = "http://parlers.ca/ezhp2000.pl";
$helpurl = "http://parlers.ca/ezhp2000.htm";

### end of set these variables
# Page formatting
$body = qq~
<BODY bgcolor="#E1EEF7" text="#000000" link="#000080" vlink="#000080" alink="#FF0000">
~;

$header = qq~
<!--HEADER STARTS-->
<TABLE border="0" width="100%" bgcolor="#000000" cellspacing="0" cellpadding="0">
<TR><TD width="100%"><TABLE border="0" width="100%" cellpadding="4">
<TR><TD width="100%" bgcolor="#0066CC">
<P align="center"><IMG border="0" src="$logourl"></p></TD>
</TR>
<TR><TD width="100%" bgcolor="#003599">
<P align="center"><B><A href="$cgiurl?newpage" class="yellow"><FONT face="verdana, helvetica, arial" size="1" color="#FDC500">create
page</FONT></A><FONT face="verdana, helvetica, arial" size="1" color="#FDC500">&nbsp;
»&nbsp; </FONT><A href="$cgiurl?editpage" class="yellow"><FONT face="verdana, helvetica, arial" size="1" color="#FDC500">edit
page</FONT></A><FONT face="verdana, helvetica, arial" size="1" color="#FDC500">&nbsp;
»&nbsp; </FONT><A href="$cgiurl?delpage" class="yellow"><FONT face="verdana, helvetica, arial" size="1" color="#FDC500">delete
page</FONT></A><FONT face="verdana, helvetica, arial" size="1" color="#FDC500">&nbsp;
»&nbsp; </FONT><A href="$helpurl" TARGET="_blank" class="yellow"><FONT face="verdana, helvetica, arial" size="1" color="#FDC500">
help</FONT></A></B></TD></TR></TABLE></TD></TR></TABLE>
<!--HEADER ENDS-->
~;

$seperator = qq~
<!--SEPERATOR STARTS-->
<TABLE border="0" width="100%" cellspacing="0" cellpadding="5">
  <TR>
    <TD width="100%">
      <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
        <TR>
          <TD width="100%"></TD>
        </TR>
      </TABLE>
    </TD>
  </TR>
</TABLE>
<!--SEPERATOR ENDS-->
~;
$footer = qq~
<!--FOOTER STARTS-->
<TABLE border="0" width="100%" cellspacing="0" cellpadding="5"><TR><TD width="100%">
<HR noshade size="1"><P align="center">
<FONT face="verdana, helvetica, arial" color="#000000" size="1">Powered by <A href="http://www.parlers.ca">Parlers.ca Unrestricted Social Posting!</A>
</FONT></TD></TR></TABLE>
<!--FOOTER ENDS-->
~;


################
# Get variables

if($ENV{'REQUEST_METHOD'} =~ /GET/i) {
    if($ENV{'QUERY_STRING'} ne "") {
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
        @pairs = split(/&/, $buffer);
        foreach $pair (@pairs) {
	    ($name,$value) = split(/\=/,$pair);
	    $name =~ s/\+/ /g;
	    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	    $value =~ s/~!/ ~!/g;
	    $value =~ s/\+/ /g;
	    $value =~ s/\n//g;
	    $value =~ s/\r/\[ENTER\]/g;
	    push (@formdata,$name);
	    push (@formdata,$value);
        }
        %formdata = @formdata;
        $current = $formdata{'directory'};
    }


        opendir(DIR,"$formdata{'directory'}") || &error('open_directory');


    close(DIR);
    
exit 0;
}

###################
# Do the uploading

$| = 1;

read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
$buffer =~ /^(.+)\r\n/;
$bound = $1;
@parts = split(/$bound/,$buffer);

$filename = $parts[1];
$parts[1] =~ s/\r\nContent\-Disposition.+\r\n//g;
$parts[1] =~ s/Content\-Type.+\r\n//g;
$parts[1] =~ s/^\r\n//;

@subparts = split(/\r\n/,$parts[2]);
$directory = $subparts[3];
$directory =~ s/\r//g;
$directory =~ s/\n//g;

$filename =~ s/Content-Disposition\: form-data\; name=\"uploaded_file\"\; filename\=//g;

@stuff = split(/\r/,$filename);
$filename = $stuff[1];
$filename =~ s/\"//g;
$filename =~ s/\r//g;
$filename =~ s/\n//g;

@a = split(/\\/,$filename);
$totalT = @a;
--$totalT;
$fname=$a[$totalT];

@a = split(/\//,$fname);
$totalT = @a;
--$totalT;
$fname=$a[$totalT];

@a = split(/\:/,$fname);
$totalT = @a;
--$totalT;
$fname=$a[$totalT];

@a = split(/\"/,$fname);
$filename=$a[0];

if($parts[1] !~ /[\w\d]/) {
    &error('no_file');
    exit 0;
}
if($imagesonly)
{
$newmain = $filename;
if ((lc(substr($newmain,length($newmain) - 4,4)) ne ".gif")&&(lc(substr($newmain,length($newmain) - 4,4)) ne ".jpg")){
    &error('wrong_type');
    exit 0;
}
}
if($nooverwrites)
{
if(-e "$directory$filename") {
 &error('no_ovoerwrite');
 exit 0;
}
}
open(REAL,">$directory$filename") || die $!;
binmode REAL;
print REAL $parts[1];
close(REAL);

`chmod $chmod $directory$filename`;


if(-e "$directory$filename") {
        print <<"END HTML";
Content-Type: text/html

<html>
$header
<title>Upload Successful</title>
</head>
$body
$separator
<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">
<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">
Success!</font></p>
<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">The Upload Was Successful.</font></p>
</table></center>
$seperator
$footer
</DIV></body>
</html>
END HTML
        exit 0;

}
else {
    print <<"END HTML";
Content-Type: text/html

<html>
<$header>
<title>Error: Upload Failed</title>
</head>
$body
$separator
<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">
<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">
Upload Failed!</font></p>
<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">The upload was unsuccessful.</font></p>
</table></center>
$seperator
$footer
</DIV></body>
</html>
END HTML
    exit 0;
}

#########
# Errors

sub error {

    local($error,@error_fields) = @_;
    if ($error eq 'no_file') {
        print <<"END HTML";
Content-type: text/html

<html>
$header
<title>Error: No File</title>
</head>
$body
$separator
<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">
<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">
No File!</font></p>
<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">You forgot to specify a file to upload. You can go back and select one.</font></p>
</table></center>
$seperator
$footer
</DIV></body>
</html>
END HTML
    }
    elsif ($error eq 'wrong_type') {
        print <<"END HTML";
Content-type: text/html

<html>
$header
<title>Error: Wrong File Type</title>
</head>
$body
$seperator
<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">
<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">
Wrong File Type!</font></p>
<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">The file you attempted to upload was not an approved type.</font></p>
</table></center>
$seperator
$footer
</DIV></body>
</html>
END HTML
    }
    elsif ($error eq 'no_ovoerwrite') {
        print <<"END HTML";
Content-type: text/html

<html>
$header
<title>Error: File Exists</title>
</head>
$body
$seperator
<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">
<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">
File Exists!</font></p>
<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">The file you attempted to upload exists at the destination. Rename the file and then attempt to upload it.</font></p>
</table></center>
$seperator
$footer
</DIV></body>
</html>
END HTML
    }
    elsif ($error eq 'open_directory') {
        print <<"END HTML";
Content-type: text/html

<html>
$header
<title>Error: Directory Cannot Be Opened</title>
</head>
$body
$seperator
<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">
<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">
File Exists!</font></p>
<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Could not open <b>$directory</b>.</font></p>
</table></center>
$seperator
$footer
</DIV></body>
</html>
END HTML
    }

    else {
        print <<"END HTML";
Content-type: text/html

<html>
$header
<title>Error!</title>
</head>
$body
$seperator
<DIV align=\"center\"><CENTER><TABLE border=\"0\" width=\"90%\" cellspacing=\"0\" cellpadding=\"0\"><TR><TD width=\"100%\">
<P><FONT face=\"verdana, helvetica, arial\" size=\"4\" color=\"#FF0000\">
Error!</font></p>
<p><FONT face=\"verdana, helvetica, arial\" size=\"2\">Error message: $_[0] </font></p>
</table></center>
$seperator
$footer
</DIV></body>
</html>
END HTML
    }
    exit 0;
}
