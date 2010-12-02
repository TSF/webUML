import htmlentitydefs
import codecs

count = 0
html  = ""

def encode(input):
  for val, tag in htmlentitydefs.codepoint2name.iteritems():
    input = input.replace(unichr(val), "&{0};".format(tag))
  return input.encode("utf-8")

file = codecs.open("supporters.txt", "r", "utf-8")
line = file.readline()
while line:
  info = line.split(";")
  if count != 0 and count % 5 == 0: html += "</tr>\n<tr>\n";
  name     = encode(info[0])
  location = encode(info[1].strip())
  html  += "  <td>{0}<br/>({1})</td>\n".format( name, location )
  count += 1
  line = file.readline()

with open('supporters.tpl', 'r') as f:
  tpl = f.read()
f.closed

print( tpl % ( count, html ) );
