import os
import numpy as np
import nibabel as nib
import matplotlib.pyplot as plt
import argparse
import glob

slice_num = 70
series = {
    0: "00036",
    1: "00042",
    2: "00045",
    3: "00051",
    4: "00052",
    5: "00055",
    6: "00084",
    7: "00086",
    8: "00088",
    9: "00122",
    10: "00128",
    11: "00129",
    12: "00133",
    13: "00134",
    14: "00140",
    15: "00141",
    16: "00145",
    17: "00148",
    18: "00150",
    19: "00160",
    20: "00183",
    21: "00197",
    22: "00219",
    23: "00267",
    24: "00285",
    25: "00295",
    26: "00301",
    27: "00302",
    28: "00307",
    29: "00312",
    30: "00314",
    31: "00332",
    32: "00352",
    33: "00353",
    34: "00354",
    35: "00355",
}


def imprimir_inferencia(serie=0, backward=False, original=False):
    global slice_num

    if original:
        # T1GD follow original
        path_recurrence = f"./mri/UPENN-GBM-{series[serie]}_21_T1GD.nii.gz"
        # T1GD base original
        path_base = f"./mri/UPENN-GBM-{series[serie]}_11_T1GD.nii.gz"
        # Segmentation file original
        path_segmentation = f"./segmentations/{serie}segmentation.nii.gz"
        img_add = path_base
        img_rec = path_recurrence
        label_add = path_segmentation
        print("Image follow original: ", path_recurrence)
        print("Image base original: ", path_base)
        print(" Segementation:", label_add)
    else:

        if backward:
            # T1GD follow original
            path_recurrence = f"./mri/UPENN-GBM-{series[serie]}_21_T1GD.nii.gz"
            # T1GD base deformada
            path_base_deformated = (
                f"./mri/UPENN-GBM-{series[serie]}_11_T1GD_ref_reg.nii.gz"
            )
            # Segmentation file deformada
            path_segmentation = f"./segmentations/{serie}segmentation_ref_reg.nii.gz"

            img_add = path_base_deformated
            img_rec = path_recurrence
            label_add = path_segmentation

            print("Image follow original: ", path_recurrence)
            print("Image base deformated: ", path_base_deformated)
            print(" Segementation deformated:", label_add)
        else:
            # T1GD base original
            path_base = f"./mri/UPENN-GBM-{series[serie]}_11_T1GD.nii.gz"
            # T1GD follow deformada
            path_follow_deformated = f"./mri/UPENN-GBM-{series[serie]}_21_T1GD_flo_reg.nii.gz"  # T1GD deformada UPENN-GBM-00036_11_T1GD_ref_reg.nii
            # Segmentation file original
            path_segmentation = f"./segmentations/{serie}segmentation.nii.gz"

            img_add = path_base
            img_rec = path_follow_deformated
            label_add = path_segmentation
            print("Image base original", path_base)
            print("Image follow deformated: ", path_follow_deformated)
            print(" Segementation:", label_add)

    img = nib.load(img_add).get_fdata()
    img_rec = nib.load(img_rec).get_fdata()
    seg_out = nib.load(label_add).get_fdata()
    seg_out = seg_out.squeeze()

    print("img_rec", img_rec.shape)

    # print("seg_out", seg_out.shape)
    fig, ax = plt.subplots(2, 2, figsize=(12, 9))
    # Ajustar los espacios entre los subplots
    plt.subplots_adjust(
        left=0.05, right=0.95, top=0.95, bottom=0.05, wspace=0.05, hspace=0.05
    )

    # Hacer que los ejes ocupen todo el espacio disponible en la figura
    fig.tight_layout()
    fig.canvas.mpl_connect(
        "scroll_event", lambda event: scroll_slices(event, img.shape[2])
    )
    fig.canvas.mpl_connect(
        "key_press_event", lambda event: key_press(event, img.shape[2])
    )

    def update_slice(slice_num):
        ax[0, 0].clear()
        ax[0, 0].imshow(
            np.rot90(img[:, :, slice_num], k=-1),
            cmap="gray",
        )  # k=-1
        ax[0, 0].set_title("Image base")

        # GT segmentation
        # ax[0, 0].clear()
        # ax[0, 0].imshow(np.rot90(label[:, :, slice_num], k=-1))
        # ax[0, 0].set_title("label")

        ax[0, 1].clear()
        ax[0, 1].imshow(np.rot90(img[:, :, slice_num], k=-1), cmap="gray")
        ax[0, 1].imshow(np.rot90(seg_out[:, :, slice_num], k=-1), cmap="jet", alpha=0.3)
        ax[0, 1].set_title("nroi + froi image base")

        # ax[1, 0].clear()
        # ax[1, 0].imshow(np.rot90(seg[0][:, :, slice_num], k=-1))
        # ax[1, 0].set_title("Map nroi")

        ax[1, 1].clear()
        ax[1, 1].imshow(np.rot90(img_rec[:, :, slice_num], k=-1), cmap="gray")
        ax[1, 1].imshow(np.rot90(seg_out[:, :, slice_num], k=-1), cmap="jet", alpha=0.3)
        ax[1, 1].set_title("nroi + froi image follow")

        ax[1, 0].clear()
        ax[1, 0].imshow(np.rot90(img_rec[:, :, slice_num], k=-1), cmap="gray")
        ax[1, 0].set_title(f"Recurrence slice {slice_num}")

        plt.draw()

    def scroll_slices(event, max_slices):
        global slice_num
        if event.button == "up":
            slice_num = (slice_num + 1) % max_slices
            update_slice(slice_num)
        elif event.button == "down":
            slice_num = (slice_num - 1) % max_slices
            update_slice(slice_num)

    def key_press(event, max_slices):
        global slice_num
        if event.key == "up":
            slice_num = (slice_num + 1) % max_slices
            update_slice(slice_num)
        elif event.key == "down":
            slice_num = (slice_num - 1) % max_slices
            update_slice(slice_num)

    update_slice(slice_num)
    plt.show()


def main():
    global slice_num
    parser = argparse.ArgumentParser(description="Visualizador de MRI")
    parser.add_argument("--serie", type=int, default=0, help="Número de serie")
    parser.add_argument(
        "--b",
        default=False,
        action="store_true",
        help="Colocar si queremos usar la deformacion backward",
    )
    parser.add_argument(
        "--o",
        default=False,
        action="store_true",
        help="Colocar si queremos ver sin deformaciones",
    )

    args = parser.parse_args()

    # seg_out = np.load(f"inferences/seg_out_{str(args.serie).zfill(5)}.npy")
    # seg_out = nib.load(
    #     f"inferences/seg_out_{str(args.serie).zfill(5)}_t.nii.gz"
    # ).get_fdata()
    # seg_out = np.load(f"../{args.result}/{args.serie}.npy")
    # seg_out = nib.load(img_add).get_fdata()
    # slice = 70  # Slice inicial

    imprimir_inferencia(args.serie, backward=args.b, original=args.o)


if __name__ == "__main__":
    main()
