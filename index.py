from PIL import Image

#im = Image.open('circle.jpg') # Can be many different formats.
#pix = im.load()
#print im.size  # Get the width and hight of the image for iterating over
#print pix[x,y]  # Get the RGBA Value of the a pixel of an image
#pix[x,y] = value  # Set the RGBA Value of the image (tuple)
#im.save('alive_parrot.png')  # Save the modified pixels as .png


im = Image.open('circle.jpeg')
pix = im.load()

width = im.size[0]
height = im.size[1]
print pix[width-1,height-1]
arr = []
col = []

#im.save(file + ".thumbnail", "JPEG")
def imageStart():
    for x in range(0, im.size[0]):
        for y in range(0, im.size[1]):
            if(y == 0 and x != 0):
                arr.append(col)
                col = []
            r = (pix[x,y])[0]
            g = (pix[x,y])[1]
            b = (pix[x,y])[2]
            if ((r + g + b) >= (225 * 3) ):
                pix[x,y] = (0,0,0)
                col.append(0)   
            else:
                pix[x,y] = (255,255,255)
                col.append(-1)

    count = 0

    #for sweep in range(0,4):
    for x in range(0, width-2):
        for y in range(0, height-2):
            if(arr[x][y] == 0):
                if(x+1 <= width-1):         # x+1
                    if(arr[x+1][y] != 0 and arr[x+1][y] != 1):
                        arr[x+1][y] == 1
                        count+=1
                if(x-1 >= 0):               # x-1
                    if(arr[x-1][y] != 0 and arr[x-1][y] != 1):
                        arr[x-1][y] == 1
                        count+=1
                if(y+1 <= height-1):        # y+1
                    if(arr[x][y+1] != 0 and arr[x][y+1] != 1):
                        arr[x][y+1] == 1
                        count+=1
                if(y-1 >= 0):               # y-1
                    if(arr[x][y-1] != 0 and arr[x][y-1] != 1):
                        arr[x][y-1] == 1
                        count+=1


    for x in range(0, width-2):
        for y in range(0, height-2):
            pix[x][y]

im.save('circle.png')