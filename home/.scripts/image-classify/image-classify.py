import argparse
import cv2
import os
import shutil

def parse_args():
    parser = argparse.ArgumentParser(prog='image-classify', description='Organise images into directories')
    # parser.add_argument('filename')           # positional argument
    # parser.add_argument('-c', '--count')      # option that takes a value
    # parser.add_argument('-v', '--verbose',
    #                     action='store_true')  # on/off flag
    parser.add_argument('files', nargs='*')
    parsed = parser.parse_args()
    return parsed

def get_chr():
    while True:
        # Wait for a key press
        key = cv2.waitKey(1)
        if key == -1:
            continue

        # If the key is one of the defined keys, move the image to the corresponding directory
        if chr(key) in "abcdefghijklmnopqrstuvwxyz0123456789":
            return chr(key)

        return False

def main():
    args = parse_args()
    image_files = args.files

    mapped = {}

    index = 0
    save = False

    # Go through each image
    while True:
        image_file = image_files[index]
        image = cv2.imread(image_file)
        cv2.imshow('image', image)
        ch = get_chr()
        if ch == 'j':
            index += 1
        elif ch == 'k':
            index -= 1
        elif ch == 'q':
            save = True
            break
        elif not ch:
            break

        mapped[image_file] = ch
        index += 1

    # Close all active window
    cv2.destroyAllWindows()

    if save:
        for image_file, ch in mapped.items():
            target_dir = os.path.join(os.path.dirname(image_file), ch)
            target_file = os.path.join(target_dir, os.path.basename(image_file))
            if not os.path.exists(target_dir):
                os.makedirs(target_dir)
            print(f"Moving {image_file} to {target_file}")
            shutil.move(image_file, target_file)

if __name__ == "__main__":
    main()
