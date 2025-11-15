import os
import cv2
import numpy as np

def save_image_edges(image_path, output_txt_path, low_thresh=100, high_thresh=200):
    """
    Detects edges in an image and writes edge pixel coordinates to a text file.

    Parameters:
        image_path (str): Path to the input image.
        output_txt_path (str): Path where the edge coordinate file will be saved.
        low_thresh (int): Lower threshold for Canny edge detection.
        high_thresh (int): Upper threshold for Canny edge detection.
    """
    print("starting")
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Load image as grayscale
    img = cv2.imread(os.path.join(script_dir, image_path), cv2.IMREAD_GRAYSCALE)
    if img is None:
        raise FileNotFoundError(f"Image not found: {os.path.join(script_dir, image_path)}")

    # Canny edge detection
    edges = cv2.Canny(img, low_thresh, high_thresh)

    # Extract edge coordinates
    ys, xs = np.where(edges > 0)
    coords = zip(xs, ys)

    # Write to text file
    with open(os.path.join(script_dir, output_txt_path), 'w') as f:
        for x, y in coords:
            f.write(f"{x},{y}\n")

    print(f"Edges saved to {os.path.join(script_dir, output_txt_path)}")


if __name__ == "__main__":     
    script_dir = os.path.dirname(os.path.abspath(__file__))
    save_image_edges("tableBackground.png", "edge_coordinates.txt")
    save_image_edges("flipperCoords.png", "flipper_coordinates.txt")
    save_image_edges("ballStartCoord.png", "ball_start_coordinates.txt")