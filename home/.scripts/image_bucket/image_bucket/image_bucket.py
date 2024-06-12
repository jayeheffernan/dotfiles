import argparse
import cv2
import os
import shutil

description = """Bucket images into subdirectories with one key press.

This will show you each image. Use j/k for next/previous, q to quit and confirm. Any other letter or number will tag that image to go to a subdirectory of that name. E.g. hit "a" to put the image under `a/`.
"""

def debug(*args):
    # print(*args)
    pass

def parse_args():
    parser = argparse.ArgumentParser(prog='image_bucket', description=description)
    parser.add_argument('files', nargs='*')
    parsed = parser.parse_args()
    return parsed

def get_chr():
    while True:
        # Wait for a key press
        key = cv2.waitKey(1)
        if key == -1:
            continue

        if chr(key) in "abcdefghijklmnopqrstuvwxyz0123456789":
            return chr(key)

        return False

def bucket(image_files):
    index = 0
    save = False
    # Map image files to subdirectories
    mapped = {}
    if len(image_files) == 0:
        return

    def jump(step):
        nonlocal index
        next = (index + step) % (len(image_files))
        debug("jumping from", index, "to", next)
        index = next

    debug("looping files", image_files)

    # Go through each image
    while True:
        debug("looping")
        image_file = image_files[index]
        debug("reading", image_file)
        image = cv2.imread(image_file)

        # Define your text and position
        text = mapped.get(image_file, "")
        position = (4, 4)
        font_scale = 4
        font_color = (255, 255, 255) # BGR, not RGB. White color here.
        line_type = 2

        # Overlay the text on the image
        cv2.putText(image,
                    text,
                    position,
                    cv2.FONT_HERSHEY_SIMPLEX,
                    font_scale,
                    font_color,
                    line_type)

        debug("showing", image_file)
        cv2.imshow('image', image)
        debug("waiting")
        ch = get_chr()
        if ch == 'j':
            jump(1)
        elif ch == 'k':
            jump(-1)
        elif ch == 'q':
            save = True
            break
        elif ch == 'x':
            # clear it
            mapped[image_file] == ""
            break;
        elif ch == 27: # Escape key
            break
        elif not ch:
            pass
        else:
            # If the key is one of the defined keys, plan to move the image to the corresponding directory
            mapped[image_file] = ch
            jump(1)

    # Close all active window
    cv2.destroyAllWindows()

    if save:
        return mapped

    return Null

image_file_exts = {'.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff'}
def classify_inputs(filenames):
    can_show = []
    associated = {}
    ignore = []
    cant_show = []

    for filename in filenames:
        basename, ext = os.path.splitext(filename)
        ext = ext.lower()
        if ext in image_file_exts:
            can_show.append(filename)
            associated[basename] = []
        elif ext == '': # probs a dir, don't worry about it
            ignore.append(filename)
        else:
            cant_show.append(filename)

    for filename in cant_show:
        basename, ext = os.path.splitext(filename)
        if basename in associated:
            associated[basename].append(filename)
        else:
            raise ValueError("Don't know what to do with extra file", filename)

    return (can_show, associated)

def move(mapped, associated):
    for mapped_image_file, ch in mapped.items():
        to_move = associated[os.path.splitext(mapped_image_file)[0]]
        to_move.append(mapped_image_file)
        for image_file in to_move:
            target_dir = os.path.join(os.path.dirname(image_file), ch)
            target_file = os.path.join(target_dir, os.path.basename(image_file))
            if not os.path.exists(target_dir):
                os.makedirs(target_dir)
            shutil.move(image_file, target_file)

def main():
    args = parse_args()
    (image_files, associated) = classify_inputs(args.files)
    mapped = bucket(image_files)
    if mapped:
        move(mapped, associated)

if __name__ == "__main__":
    main()
