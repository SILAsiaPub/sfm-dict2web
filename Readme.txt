Readme.txt

SIL Philippines Dictionary Creator
----------------------------------
These files are used to create a web dictionary from SIL Philippines sfm files. 
There is flexibility buit in to allow for differences in format. No two 
dictionaries are the same.

It could be used for any other dictionary sfm format such as MDF but I have not 
used it for that purpose.

To Start:
copy your sfm files into a subfolder usually named by the ISO code.
data\iso\iso-dict.sfm.txt
Open a command prompt window at the directory where the dict.cmd is located.
The first time just type dict and press enter.
It will prompt you to answer questions. This is making a variable file in the
folder var. It will take the name iso code and cmd extension. i.e. ivb.cmd

After you have made the iso.cmd file start like this:
dict ivb<Enter>

First run the Assess SFM to check some aspects of the contents.
Type:
0<Enter>

The files in the setup folder of the ISO project will need some tweaking.

Type:
a<Eenter>
to start the xml conversion.
Initially the sfm file undergoes some cct changes found listed 
in pre-xml-ccts.txt. Typically unique changes
for that language only. Put these in the file iso.cct in the scripts\cct folder.
Often Philippines dictionaries need converting to UTF-8. And also many need 
wedge quote changes
So the pre-xml-ccts.txt file often contains.
%iso%.cct
_fix_wedge_quotes.cct
_Lg2utf8.cct

The file is then converted to XML.
If a file exists fields-to-remove.txt in setup then the listed fields are removed.
The spacees are normalized for each field (except the table that 
has already been done)
A cct is run to convert bar codes and + and _ markup to xml
The file is validated for well formed xml
The entries are grouped under lxGroup (like in Toolbox export)
The entries are sorted by lx field. Using a default collation that 
ignores accented characters or a named custom collation. The only named custom
collation at present is "yakan". Othes can be made by editing the 
dict-custom-collation.xslt file. Follow the Yakan example.

Now grouping is done for the type of dictionary normally PLB.
Example sentences and translations are grouped

Next the extra-tasks.txt list is processed. The contents of that file are listed:
# entries following semicolon are ignored
# Ibatan ivb
genericGroupstartwithlist lxGroup "ms ode ose oid"
genericgrouping lxGroup ps "odeGroup oseGroup oidGroup"
genericgrouping msGroup ps
genericnewgroupselect gl it ii iv
genericgroupserialnodes  "ra re rg rs rt sc it ii iv"

genericGroupstartwithlist
Within the lxGroup the grouping is restarted by any of the listed fields.

genericgrouping
Within the lxGroup all are grouped under psGroup including ps field, 
except the fields in the "list".

genericnewgroupselect
the first parameter gl is the grouping field glGroup
Any following (including serial fields of the same name) are grouped within 
glGroup in the order of the parameters

genericgroupserialnodes
These fields occur serially so are grouped raGroup contains serial ra fields, etc.

The final file is copied to iso-a.xml in the data/iso/xml folder

Several checks are run on the xml files to get a field count and count some 
of the contents. A ps-check.xml file in the checks directory shows the range of 
data in the ps field.

Have a look at all files in the data\iso\checks folder to get a 
feel for the issues. 

