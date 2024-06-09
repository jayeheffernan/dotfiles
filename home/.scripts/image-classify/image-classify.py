# importing the tkinter module and PIL
# that is pillow module
from tkinter import *
from PIL import ImageTk, Image
import argparse

def parse_args():
    parser = argparse.ArgumentParser(prog='image-classify', description='Organise images into directories')
    # parser.add_argument('filename')           # positional argument
    # parser.add_argument('-c', '--count')      # option that takes a value
    # parser.add_argument('-v', '--verbose',
    #                     action='store_true')  # on/off flag
    parser.add_argument('files', nargs='*')
    parsed = parser.parse_args()
    return parsed

def forward(img_no):
    global label
    global button_forward
    global button_back
    global button_exit
    global image_list

    label.grid_forget()

    label = Label(image=image_list[img_no-1])
    label.grid(row=1, column=0, columnspan=3)
    button_forward = Button(root, text="forward",
                        command=lambda: forward(img_no+1))

    if img_no == 4:
        button_forward = Button(root, text="Forward",
                                state=DISABLED)

    button_back = Button(root, text="Back",
                         command=lambda: back(img_no-1))

    button_back.grid(row=5, column=0)
    button_exit.grid(row=5, column=1)
    button_forward.grid(row=5, column=2)

def back(img_no):
    global label
    global button_forward
    global button_back
    global button_exit
    global image_list

    label.grid_forget()

    label = Label(image=image_list[img_no - 1])
    label.grid(row=1, column=0, columnspan=3)
    button_forward = Button(root, text="forward",
                            command=lambda: forward(img_no + 1))
    button_back = Button(root, text="Back",
                         command=lambda: back(img_no - 1))

    if img_no == 1:
        button_back = Button(root, text="Back", state=DISABLED)

    label.grid(row=1, column=0, columnspan=3)
    button_back.grid(row=5, column=0)
    button_exit.grid(row=5, column=1)
    button_forward.grid(row=5, column=2)

def main():
    global label
    global button_forward
    global button_back
    global button_exit
    global image_list

    args = parse_args()
    root = Tk()
    root.title("Image Classifier")
    root.geometry("700x700")

    image_list = [ImageTk.PhotoImage(Image.open(fname)) for fname in args.files];

    label = Label(image=image_no_1)
    label.grid(row=1, column=0, columnspan=3)

    button_back = Button(root, text="Back", command=back,
                        state=DISABLED)
    button_exit = Button(root, text="Exit", command=root.quit)
    button_forward = Button(root, text="Forward", command=lambda: forward(1))

    button_back.grid(row=5, column=0)
    button_exit.grid(row=5, column=1)
    button_forward.grid(row=5, column=2)

    root.mainloop()

if __name__ == "__main__":
    main()
