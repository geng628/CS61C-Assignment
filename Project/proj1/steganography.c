/************************************************************************
**
** NAME:        steganography.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Dan Garcia  -  University of California at Berkeley
**              Copyright (C) Dan Garcia, 2020. All rights reserved.
**				Justin Yokota - Starter Code
**				YOUR NAME HERE
**
** DATE:        2020-08-23
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include "imageloader.h"

//Determines what color the cell at the given row/col should be. This should not affect Image, and should allocate space for a new Color.
Color *evaluateOnePixel(Image *image, int row, int col)
{
	//YOUR CODE HERE
	uint8_t cur = image->image[row][col].B;
	uint8_t p = cur & 0b1;
	Color *t = (Color *)malloc(sizeof(Color));
	if (p == 1){
		t->R = 255;
		t->G = 255;
		t->B = 255;
		return t;
	}
	t->R = 0;
	t->B = 0;
	t->G = 0;
	return t;
}

//Given an image, creates a new image extracting the LSB of the B channel.
Image *steganography(Image *image)
{
	//YOUR CODE HERE
	Image *new_image = (Image *)malloc(sizeof(Image));
	new_image->rows = image->rows;
	new_image->cols = image->cols;
	new_image->image = (Color **)malloc(sizeof(Color *) * image->rows);
	for (int i = 0; i < new_image->rows;++i){
		new_image->image[i] = (Color *)malloc(sizeof(Color) * new_image->cols);
	}
	for (uint32_t i = 0; i < image->rows;i++){
		for (uint32_t j = 0; j < image->cols;++j){
			Color *temp = evaluateOnePixel(image, i, j);
			//值传递
			new_image->image[i][j] = *temp;
			free(temp);
		}
	}
	return new_image;
}

/*
Loads a file of ppm P3 format from a file, and prints to stdout (e.g. with printf) a new image, 
where each pixel is black if the LSB of the B channel is 0, 
and white if the LSB of the B channel is 1.

argc stores the number of arguments.
argv stores a list of arguments. Here is the expected input:
argv[0] will store the name of the program (this happens automatically).
argv[1] should contain a filename, containing a file of ppm P3 format (not necessarily with .ppm file extension).
If the input is not correct, a malloc fails, or any other error occurs, you should exit with code -1.
Otherwise, you should return from main with code 0.
Make sure to free all memory before returning!
*/
int main(int argc, char **argv)
{
	//YOUR CODE HERE
	if(argc <= 1){
		return -1;
	}
	char *filename = argv[1];
	Image *image = readData(filename);
	Image *new_image = steganography(image);
	writeData(new_image);
	freeImage(image);
	freeImage(new_image);
	return 0;
}
