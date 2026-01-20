/************************************************************************
**
** NAME:        imageloader.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Dan Garcia  -  University of California at Berkeley
**              Copyright (C) Dan Garcia, 2020. All rights reserved.
**              Justin Yokota - Starter Code
**				YOUR NAME HERE
**
**
** DATE:        2020-08-15
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include "imageloader.h"

//Opens a .ppm P3 image file, and constructs an Image object. 
//You may find the function fscanf useful.
//Make sure that you close the file with fclose before returning.
Image *readData(char *filename) 
{
	//YOUR CODE HERE
	FILE *file = fopen(filename, "r");//打开文件流，从文件中读取像素
	Image *file_image = (Image*)malloc(sizeof(Image));
	//p3
	char type[10];
	fscanf(file, "%s", type);
	//[cols][rows]
	fscanf(file, "%u %u", &file_image->cols, &file_image->rows);
	// 255  这里就是颜色的范围
	int size = 0;
	fscanf(file, "%d", &size);//image就是像素待的地方，像素列表,其实就是二维数组
	//这里纯粹就是进行动态分配空间,相当于二维数组
	file_image->image = (Color **)malloc(file_image->rows * sizeof(Color *));
	for (uint32_t i = 0; i < file_image->rows; i++)
	{
		file_image->image[i] = (Color *)malloc(file_image->cols * sizeof(Color));
		//一个像素三个数
	}
	//RPG
	for (uint32_t i = 0; i < file_image->rows;i++){
		for (uint32_t j = 0; j < file_image->cols;j++){
			fscanf(file, "%hhu %hhu %hhu", &file_image->image[i][j].R, &file_image->image[i][j].G, &file_image->image[i][j].B);
		}
	}
	fclose(file);
	return file_image;
}
//上面这个就是read

//Given an image, prints to stdout (e.g. with printf) a .ppm P3 file with the image's data.
void writeData(Image *image)
{
	//YOUR CODE HERE
	printf("P3\n");
	printf("%u %u\n", image->cols, image->rows);
	printf("255\n");
	//打印二维数组
	for (uint32_t i = 0; i < image->rows;++i){
		for (uint32_t j = 0; j < image->cols;++j){
			printf("%3d %3d %3d", image->image[i][j].R, image->image[i][j].G, image->image[i][j].B);
			if(j < image->cols - 1){
				printf("   ");
			}
		}
		printf("\n");
	}
}

//Frees an image
void freeImage(Image *image)
{
	//YOUR CODE HERE
	for (uint32_t i = 0; i < image->rows; ++i){
		free(image->image[i]);
	}
	free(image->image);
	free(image);
}