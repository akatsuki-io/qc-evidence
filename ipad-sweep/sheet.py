#!/usr/bin/env python3
# usage: sheet.py out.png cellW img1 img2 ...  — contact sheet, filename captioned under each
import sys; from PIL import Image, ImageDraw
out, w, files = sys.argv[1], int(sys.argv[2]), sys.argv[3:]
ims=[]
for f in files:
    im=Image.open(f); r=w/im.width; ims.append((f.split('/')[-1], im.resize((w,int(im.height*r)))))
h=max(i.height for _,i in ims)+18
sheet=Image.new('RGB',(w*len(ims),h),'white'); d=ImageDraw.Draw(sheet)
for k,(n,i) in enumerate(ims):
    sheet.paste(i,(k*w,18)); d.text((k*w+4,2),n,fill='black')
sheet.save(out); print(out)
