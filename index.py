from PIL import Image
import math
#im = Image.open('circle.jpg') # Can be many different formats.
#pix = im.load()
#print im.size  # Get the width and hight of the image for iterating over
#print pix[x,y]  # Get the RGBA Value of the a pixel of an image
#pix[x,y] = value  # Set the RGBA Value of the image (tuple)
#im.save('alive_parrot.png')  # Save the modified pixels as .pngs
#
# im = Image.open('circle.jpeg')
# pix = im.load()

# width = im.size[0]
# height = im.size[1]
#im.save(file + ".thumbnail", "JPEG")
#def imageStart():
# for x in range(0, im.size[0]):
#     for y in range(0, im.size[1]):
        # if(y == 0 and x != 0):
        #     arr.append(col)
        #     col = []
        # r = (pix[x,y])[0]
        # g = (pix[x,y])[1]
        # b = (pix[x,y])[2]
        # if ((r + g + b) >= (225 * 3) ):
        #     pix[x,y] = (0,0,0)
        #     col.append(0)
        # else:
        #     pix[x,y] = (255,255,255)
        #     col.append(1000)

#count = 0
def test():
    arr = []
    col = []
    max = 0
    width = 15
    height = 15
    radius = width/5
    xc = width/2
    print xc
    yc = height/2
    print yc
    for x in range(0, width):
        col = []
        for y in range(0, height):
            if( (x-xc)^2 + (y-yc)^2 - radius^2 <  0 ): #and ((x -xc)^2 + (y-yc)^2) - radius > -0.5
                col.append(0)
            else:
                col.append(1)
        arr.append(col)

    fb = open("results.txt", "w")
    for x in range(0, width):
        for y in range(0, height):
            fb.write('%d | ' % arr[x][y])
        fb.write('\n\n');


def main():
    arr = []
    col = []
    max = 0
    width = 10
    height = 10
    radius = width/5
    xc = width/2
    yc = height/2
    for x in range(0, width):
        for y in range(0, height):
            if( (x-xc)^2 + (y-yc)^2 - radius^2 <  0 ): #and ((x -xc)^2 + (y-yc)^2) - radius > -0.5
                col.append(0)
            else:
                col.append(1000)
        arr.append(col)
        col = []


    #initally find all pixels that border a shape
    # for x in range(0, width-2):
    #     for y in range(0, height-2):
    #         if(arr[x][y] == 0):
    #             if(x+1 <= width-1):         # x+1
    #                 if(arr[x+1][y] != 0 and arr[x+1][y] != 1):
    #                     arr[x+1][y] == 1
    # #                    count+=1
    #             if(x-1 >= 0):               # x-1
    #                 if(arr[x-1][y] != 0 and arr[x-1][y] != 1):
    #                     arr[x-1][y] == 1
    # #                    count+=1
    #             if(y+1 <= height-1):        # y+1
    #                 if(arr[x][y+1] != 0 and arr[x][y+1] != 1):
    #                     arr[x][y+1] == 1
    # #                    count+=1
    #             if(y-1 >= 0):               # y-1
    #                 if(arr[x][y-1] != 0 and arr[x][y-1] != 1):
    #                     arr[x][y-1] == 1
    # #                    count+=1

    maxM = 0.01

    #def fastSweep():
    for sweep in range(0,8):
        for x in range(0, width-2):
            for y in range(0, height-2):
        #            ULtoLR
                if(arr[x][y] != 0):
                    if(x+1 <= width-1):              # R side
                        if(arr[x+1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x+1][y] + 1


                    if(x-1 >= 0):                   # L side
                        if(arr[x-1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x-1][y] + 1


                    if(y+1 <= height-1):            # Lower
                        if(arr[x][y+1] < arr[x][y] + 1):
                            arr[x][y] = arr[x][y+1] + 1


                    if(y-1 >= 0):                   # Upper
                        if(arr[x][y-1] < arr[x][y]):
                            arr[x][y] = arr[x][y-1] + 1


        for x in range(0, width-2):
            for y in range(height-2, 0, -1):
        #            LLtoUR
                if(arr[x][y] != 0):

                    if(x+1 <= width-1):              # R side
                        if(arr[x+1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x+1][y] + 1


                    if(x-1 >= 0):                   # L side
                        if(arr[x-1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x-1][y] + 1


                    if(y+1 <= height-1):            # Lower
                        if(arr[x][y+1] < arr[x][y] + 1):
                            arr[x][y] = arr[x][y+1] + 1


                    if(y-1 >= 0):                   # Upper
                        if(arr[x][y-1] < arr[x][y] + 1):
                            arr[x][y] = arr[x][y-1] + 1

        for x in range(width-2, 0, -1):
            for y in range(height-2, 0, -1):
        #            LRtoUL
                if(arr[x][y] != 0):

                    if(x+1 <= width-2):              # R side
                        if(arr[x+1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x+1][y] + 1


                    if(x-1 >= 0):                   # L side
                        if(arr[x-1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x-1][y] + 1


                    if(y+1 <= height-2):            # Lower
                        if(arr[x][y+1] < arr[x][y] + 1):
                            arr[x][y] = arr[x][y+1] + 1


                    if(y-1 >= 0):                   # Upper
                        if(arr[x][y-1] < arr[x][y] + 1):
                            arr[x][y] = arr[x][y-1] + 1
        for x in range(width-2, 0, -1):
            for y in range(0, height-2):
        #            URtoLL

                if(arr[x][y] != 0):
                    if(x+1 <= width-2):              # R side
                        if(arr[x+1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x+1][y] + 1


                    if(x-1 >= 0):                   # L side
                        if(arr[x-1][y] < arr[x][y] + 1):
                            arr[x][y] = arr[x-1][y] + 1


                    if(y+1 <= height-2):            # Lower
                        if(arr[x][y+1] < arr[x][y] + 1):
                            arr[x][y] = arr[x][y+1] + 1


                    if(y-1 >= 0):                   # Upper
                        if(arr[x][y-1] < arr[x][y] + 1):
                            arr[x][y] = arr[x][y-1] + 1

    # print
    fb = open("results.txt", "w")
    for x in range(0, width-1):
        for y in range(0, height-1):
            fb.write('%d | ' % arr[x][y])
        fb.write('\n');


#main()
test()
