GAMS Posix Utilities
====================

Starting with distribution 20.6 the GAMS system for Windows includes a
collection of Posix utilities which are usually available for the different Unix
systems and therefore help to write platform independent scripts.

The following utilities are available:

awk    - Pattern scanning and processing language (*)
cat    - Concatenate and print files
cksum  - Write file checksums and sizes
cmp    - Compare two files
comm   - Select or reject lines common to two files
cp     - Copy files
cut    - Cut out selected fields of each line of a file
diff   - Compare two files
expr   - Evaluate arguments as an expression
fold   - Fold lines
gsort  - Sort, merge, or sequence check text files (*)
grep   - File pattern searcher
gdate  - Write the date and time (*)
head   - Copy the first part of files
join   - Relational database operator
mv     - Move files
od     - Dump files in various formats
paste  - Merge corresponding or subsequent lines of files
printf - Write formatted output
rm     - Remove directory entries
sed    - Stream editor
sleep  - Suspend execution for an interval
tail   - Copy the last part of a file
tee    - Duplicate standard input
test   - Evaluate expression
tr     - Translate characters
uniq   - Report or filter out repeated lines in a file
wc     - Word, line, and byte count
xargs  - Construct argument list(s) and invoke utility

(*) Please note that the utilities "date" and "sort" have been renamed to
"gdate" and "gsort" to avoid conficts with the Windows commands "date" and
"sort". For compatibility reasons the GNU implementation of awk called "gawk"
has been renamed to "awk".

The collection consists of native Windows ports of GNU implementation of these
utilities taken from the Web page http://unxutils.sourceforge.net. Detailed
descriptions of the utilities can be found at http://www.gnu.org/ or through
Unix man pages (e.g. Linux man pages with a web interface can be found at
http://www.linuxjournal.com/modules.php?op=modload&name=NS-help&file=man).

The model schulz.gms (http://www.gamsworld.org/performance/schulz.htm)
demonstrates the use of some of these utilities.
