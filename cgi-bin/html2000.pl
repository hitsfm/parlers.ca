# THIS FILE CONTAINS HTML USED BY HOMEPAGE.PL - EDIT IT TO SUIT YOUR NEEDS!

############################################################################################################
# BODY TAG - USED FOR YOUR PAGES (NOT USER PAGES) ##########################################################

$badj_body = qq~
<BODY bgcolor="#E1EEF7" text="#000000" link="#000080" vlink="#000080" alink="#FF0000">
~;

############################################################################################################
# CSS STYLES / STYLE LINKS - CONTAINS CSS STYLES FOR GENERATOR'S PAGES (NOT USER PAGES) ####################
# DELETE THE CONTENTS OF THIS IF YOU DON'T WANT TO USE CSS

$badj_css = qq~
<LINK rel="stylesheet" type="text/css" href="$baseurl/css/main.css">
~;

############################################################################################################
# STANDARD USER PAGES CSS LINK - SETS STYLES FOR USER PAGES (USEFUL FOR USE WITH YOUR USER PAGE HEADER) ####
# DELETE THE CONTENTS OF THIS IF YOU DON'T WANT TO USE CSS

$hp_css = qq~
<LINK rel="stylesheet" type="text/css" href="$baseurl/css/hp.css">
~;

############################################################################################################
# STANDARD HEADER - USED BY THE SCRIPT'S PAGES #############################################################

$badj_header = qq~
<!--HEADER STARTS-->
<TABLE border="0" width="100%" bgcolor="#000000" cellspacing="0" cellpadding="0">
<TR><TD width="100%"><TABLE border="0" width="100%" cellpadding="4">
<TR><TD width="100%" bgcolor="#0066CC">
<P align="center"><IMG border="0" src="$imageurl/logo.gif"></p></TD>
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

# USERPAGE HEADER ##########################################################################################
# This is placed at the top of user pages. It's reccomended you use an SSI pointing to a page
# containing the header so it can be easily updated on all pages. If you haven't gos SSI just
# include the HTML of the header here. Delete the HTML if you don't want to include a header.

$userpage_header = qq~
<!--HEADER STARTS-->
<TABLE border="0" width="100%" bgcolor="#000000" cellspacing="0" cellpadding="0">
<TR><TD width="100%"><TABLE border="0" width="100%" cellpadding="4">
<TR><TD width="100%" bgcolor="#003599">
<P align="center"><A href="$baseurl" class=$toptextcolor><FONT face="verdana, helvetica, arial" size="1" color=$topbackcolor><B>$topofuserpages
</B></FONT></A></p></TD>
</TR></TABLE></TD></TR></TABLE>
<!--HEADER ENDS-->
~;

# SEPERATOR ################################################################################################
# Don't worry about this - it's just a html seperator table to space things out on the page.

$badj_seperator = qq~
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

# BADJ FOOTER ##############################################################################################
# The footer displayed beneath homepage.pl's forms. 

$badj_footer = qq~
<!--FOOTER STARTS-->
<TABLE border="0" width="100%" cellspacing="0" cellpadding="5"><TR><TD width="100%">
<HR noshade size="1"></TABLE>
<!--FOOTER ENDS-->
~;

# COPYRIGHT NOTICE #########################################################################################
# This need not be a copyright notice, but it's what is displayed at the bottom of user pages.
$copyright_notice = qq~
<!--FOOTER STARTS-->
<P><FONT face="verdana, helvetica, arial" color="#000000" size="1">This post was
generated by <A href="http://parlers.ca">Parlers.ca</A>
</FONT></P>
<!--FOOTER ENDS-->
~;
