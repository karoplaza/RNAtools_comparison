import json
import sys
print('chain1,resname1,resno1,chain2,resname2,resno2,type')
with open(sys.argv[1], 'r', encoding='utf-8') as f:
    data = json.load(f)
bps = data['basepairs']
for bp in bps:
    bps = bp['basepair']
    a = bps[-1].lower()
    bps = bps[:-1].replace(':', '')
    bps = bps.upper()
    if bps == "HS":
       bps = "SH"
    elif bps == "WS":
       bps = "SW"
    elif bps == "WH":
       bps = "HW"
    bps = a + bps
    if int(bp['resnum1']) < int(bp['resnum2']):
        print('{},{},{},{},{},{},{}'.format(bp['chain1'],bp['resname1'],bp['resnum1'],bp['chain2'],bp['resname2'],bp['resnum2'],bps))
