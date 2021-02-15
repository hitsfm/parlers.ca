#!C:\perl\bin\perl.exe

my($version) = "1.1e";
my($incSub);
#############################################################################
# jasearch.pl - Simple search script - Version 1.1a 
#
# requires 4 paramaters from form
#
# 'sv'    = search value
# 'type'  = all terms or any terms
# 'base'  = base directory to search
# 'rbase' = returned base
#
# optionals
#
# 'background' = gif to display as background
# 'text'       = text colour
# 'link'       = colour of links
# 'alink'      = colour of active link
# 'vlink'      = colour of visited links
# 'bgcolor'    = colour of background
# 'log'        = log file
#
# base = /home/son & rbase = http://parlers.ca
#
# /home/son/son.html would be http://parlers.ca/son.html
#
# 
#############################################################################

&readForm;

$listdirs = 0;
if ($FORM{'dirs'} ne "") { 
	@directories = split(/;/,$FORM{'dirs'});
	$listdir = 1;
        $FORM{'subdirs'} = "no";
}

$incSub = 1;
if (lc($FORM{'subdirs'}) eq "no") { $incSub = 0; }

&printHtmlTop;

if ($listdir > 0) { 
	foreach $dir (@directories) {
		&checkFiles($FORM{'base'}."$dir");
	}
} else {
	&checkFiles($FORM{'base'});
}
&printHtmlBottom;

sub printHtmlTop {
# prints top part of html file, upto the list of files.....
    if ($FORM{'log'} ne "") { doLog(); }

    print "Content-type: text/html\n\n";
    print "<HTML><HEAD><TITLE>Search Results</TITLE></HEAD>\n";
    print "<BODY";
    $body = "";
    

    if ($FORM{'background'} ne "") { $body = "$body BACKGROUND=\"$FORM{'background'}\" "; }
    if ($FORM{'bgcolor'} ne "") { $body = "$body BGCOLOR=\"$FORM{'bgcolor'}\" "; }
    if ($FORM{'text'} ne "") { $body = "$body TEXT=\"$FORM{'text'}\" "; }
    if ($FORM{'link'} ne "") { $body = "$body LINK=\"$FORM{'link'}\" "; }
    if ($FORM{'alink'} ne "") { $body = "$body ALINK=\"$FORM{'alink'}\" "; }
    if ($FORM{'vlink'} ne "") { $body = "$body VLINK=\"$FORM{'vlink'}\" "; }
    if ($body eq "") { $body = " BGCOLOR=\"#FFFFFF\""; }
    print "$body>\n";
    print "<CENTER><FONT SIZE=\"6\"><STRONG>Search Results</STRONG></FONT></CENTER><HR><P>\n";
    print "<FORM METHOD=\"post\" ACTION=\"$ENV{'SCRIPT_NAME'}\">\n";
    print "<INPUT TYPE=\"hidden\" NAME=\"base\" VALUE=\"$FORM{'base'}\">\n";
    print "<INPUT TYPE=\"hidden\" NAME=\"rbase\" VALUE=\"$FORM{'rbase'}\">\n";
    if ($FORM{'background'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"background\" VALUE=\"$FORM{'background'}\">\n"; }
    if ($FORM{'bgcolor'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"bgcolor\" VALUE=\"$FORM{'bgcolor'}\">\n"; }
    if ($FORM{'text'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"text\" VALUE=\"$FORM{'text'}\">\n"; }
    if ($FORM{'link'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"link\" VALUE=\"$FORM{'link'}\">\n"; }
    if ($FORM{'alink'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"alink\" VALUE=\"$FORM{'alink'}\">\n"; }
    if ($FORM{'vlink'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"vlink\" VALUE=\"$FORM{'vlink'}\">\n"; }
    if ($FORM{'log'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"log\" VALUE=\"$FORM{'log'}\">\n"; }
	if ($FORM{'dirs'} ne "") { print "<INPUT TYPE=\"hidden\" NAME=\"dirs\" VALUE=\"$FORM{'dirs'}\">\n"; }
    print "Search for ";
    print "<INPUT TYPE=\"text\" NAME=\"sv\" VALUE=\"$FORM{'sv'}\">\n";
    print "and match ";
    print "<SELECT NAME=\"type\">\n";
    print "<OPTION VALUE=\"all\"";
    if ($FORM{'type'} eq "all") { print " SELECTED"; }
    print ">all\n";
    print "<OPTION VALUE=\"any\"";
    if ($FORM{'type'} eq "any") { print " SELECTED"; }
    print ">any\n";
    print "</SELECT> terms.\n";
    print "<INPUT TYPE=\"submit\" VALUE=\"Search\">\n";
    print "<INPUT TYPE=\"reset\" VALUE=\"Clear\"></FORM>\n";
    print "<P>Results are not returned in any specific order:<P>\n";
    print "<UL>\n";
}

sub printHtmlBottom {
# prints last part of html file after list of files....
    print "</UL>\n";

    if ($numberreturned == 0) {
        print "<H2>Sorry no matches found!</H2>\n";
    } else {
        print "<P>Found $numberreturned match";
        if (!($numberreturned == 1)) { print "es"; };
        print "\n";
    }
    print "<P><HR><CENTER>jasearch.pl V$version<BR>&copy; Copyright Parlers.ca";
    print "<P></CENTER>\n";
    print "</BODY>\n</HTML>\n";
}


sub readForm {
# reads data pairs from form
    read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
    if ($buffer eq "") { $buffer = $ENV{'QUERY_STRING'}; }

    @pairs = split( /&/, $buffer);

    foreach $pair (@pairs) {
        ($name, $value) = split(/=/, $pair);

        $value =~ tr/+/ /;
        $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg;
        $FORM{lc($name)} = $value;
    }

    @search = split( / /, $FORM{'sv'});
    my($numberreturned) = 0;
}   

sub checkFiles {
# read files in directory, passed as first paramater
    my($path) = shift;
    my($fullFilename);
    my(@files);
    my(@lines);
    my($line);
    my($title);

    opendir(ROOT,$path);
    @files = readdir(ROOT);
    closedir(ROOT);

    foreach (@files) {
        next if /^\.|\.\.$/;

		if ($_ =~ m/_vti_cnf/i) { next; }

        $fullFilename = "$path/$_";

        if (-d $fullFilename) {
	 		if ($incSub > 0) { checkFiles($fullFilename); }
            next;
        }

        if ($fullFilename =~ m/\.htm/i || $fullFilename =~ m/\.sht/i) {
            open(FILE, $fullFilename);
            @lines = <FILE>;
            close(FILE);

            $line = join(' ',@lines);
            $line =~ s/\n//g;

            $title = "No Title";
            if($line =~ m!<title>(.+)</title>!i) {
                $title = $1;
            };

            if ($FORM{'type'} =~ m/all/i ) {
                $found = 1;
                foreach $se (@search) {
                    if ($line !~ m/$se/i) { $found = 0; }
                }
            } else {
                $found = 0;
                foreach $se (@search) {
                    if ($line =~ m/$se/i) { $found = 1; }
                }
            }


			if ($line =~ m!NOSEARCH!i) {
				$found = 0;
			}

            if ($found == 1 ) {
                $tmp = $fullFilename;
                $tmp =~ s/$FORM{'base'}//;
                $tmp = "$FORM{'rbase'}$tmp";

                print "<LI><a href=\"$tmp\">$title</a>\n";
                $numberreturned++;
            }
        }

    }
}

sub doLog {
#write details of use to log file
    my($site);

    $site = $ENV{'REMOTE_HOST'};
    if ($site eq "") { $site = $ENV{'REMOTE_ADDR'}; }

    if (!(-e "$FORM{'log'}" )) {
        open( OUTFILE,">$FORM{'log'}") or return;
        print OUTFILE "\"searh value\",\"search type\",\"time\",\"remote site\"\n";
        close(OUTFILE);
    }

    open( OUTFILE,">>$FORM{'log'}") or return;
    print OUTFILE "\"$FORM{'sv'}\",\"$FORM{'type'}\",\"" . localtime() . "\",\"$site\"\n";
    close( OUTFILE );
}

