#include "stdafx.h"
#include "opencv2/opencv.hpp"
#include <stdio.h>

using namespace std;
using namespace cv;

//Estrutura para armazenar os atributos extraidos
struct features {
	double max_width; 
	double max_height;
	double max_perimeter;
	double max_area;
	double max_angle;
	double max_aspect_ratio;
	double max_convex_hull_area;
	double max_majoraxis_ellipse;
	double max_minoraxis_ellipse;
	double max_angle_ellipse;
	double hu1;
	double hu2;
	double hu3;
	double hu4;
	double hu5;
	double hu6;
	double hu7;
};

//Função que extrai algumas caracteristicas estruturais da imagem img passanda como paramentro
features ExtractStructuralFeatures(Mat& img) {
	//vetor de pontos para o contorno dos objetos da imagem
	vector<vector<Point>> contours;    
	//estrutura de caracteristicas
	features result;
	//largura maxima do maior objeto encontrado até o momento
	double max_width = 0;
	//largura maxima do maior objeto encontrado até o momento
	double max_height = 0;
	//perimetro maximo do maior objeto encontrado até o momento
	double max_perimeter = 0;
	//area maxima do maior objeto encontrado até o momento
	double max_area = 0;
	//angulo maximo do maior objeto encontrado até o momento
	double max_angle = 0;
	//angulo maximo da elipse do maior objeto encontrado até o momento
	double max_angle_ellipse = 0;
	//eixo minimo e maximo da elipse do maior objeto encontrado até o momento
	double max_majoraxis_ellipse = 0;
	double max_minoraxis_ellipse = 0;
	//area maxima do convex hull do maior objeto encontrado até o momento
	double max_convex_hull_area = 0;
	//armazena os momentos de Hu
	CvMoments max_hu_moments;
	CvHuMoments max_hu;

	//encontra todos os contornos dos objetos da imagem
	findContours(img, contours, CV_RETR_LIST, CV_CHAIN_APPROX_NONE);

	//cria uma nova imagem
	Mat cimage = Mat::zeros(img.size(), CV_8UC3);

	//percore todos os objetos encontrados na imagem
	for(size_t i = 0; i < contours.size(); i++) {
		//verica quantos pontos o contorno do objeto i possui
		size_t count = contours[i].size();

		//calcula a area do objeto
		double area = cv::contourArea(contours[i]);

		//se for menor do que 6 descarta
		if(area < 2000) {
			continue;
		}

		//desenha os contornos do objeto na imagem cimage
		drawContours(cimage, contours, (int)i, Scalar::all(255), 1, 8);		    

		//retangulo englobante minimo no tamanho do contorno do objeto
		vector<RotatedRect> minRect(contours.size());

		//elipse englobante minima no tamanho do contorno do objeto
		vector<RotatedRect> minEllipse(contours.size());

		//Calcula o retangulo englobante minimo para os contornos
		minRect[i] = minAreaRect(Mat(contours[i]));
		minEllipse[i] = fitEllipse(Mat(contours[i])); 

		//Desenha o retantulo englobante na imagem cimage
		Point2f rect_points[4]; 
		minRect[i].points(rect_points);
		for(int j = 0; j < 4; j++ ) {
			line(cimage, rect_points[j], rect_points[(j+1)%4], Scalar(0,255,0), 1, 8 );	
		}

		//Desenha a elipse englobante na imagem cimage
		ellipse(cimage, minEllipse[i], Scalar(255,0,0), 1, 8 );

		//Calcula convex hull
		vector<vector<Point>>hull(contours[i].size());
		convexHull(Mat(contours[i]), hull[i], false );  

		//desenha o convex hull na imagem cimage
		drawContours(cimage, hull, i, Scalar(0,0,255), 1, 8, vector<Vec4i>(), 0, Point());

		//se a area for maior do que a maior area encontrada até o momento
		if (area > max_area) {
			//atualiza a altura, largura, area e perimetro do maior objeto encontrado até o momento
			max_width = minRect[i].size.width;
			max_height = minRect[i].size.height;
			max_area = area;
			//calcula a area do convex hull
			max_convex_hull_area = cv::contourArea(hull[i]);
			//calcula o perimetro
			max_perimeter = cv::arcLength(contours[i], true);	
			//atualiza o angulo do retangulo e da elipse
			max_angle = minRect[i].angle;
			max_angle_ellipse = minEllipse[i].angle;

			//atualiza os eixos da elipse
			if (minEllipse[i].size.width > minEllipse[i].size.height) {
				max_majoraxis_ellipse = minEllipse[i].size.width;
				max_minoraxis_ellipse = minEllipse[i].size.height;
			}	else {
				max_majoraxis_ellipse = minEllipse[i].size.height;
				max_minoraxis_ellipse = minEllipse[i].size.width;
			}
			//Calcula e atualiza os momentos de Hu do maior objeto encontrado na imagem até o momento
			max_hu_moments = cv::moments(contours[i], true);			
			cvGetHuMoments(&max_hu_moments, &max_hu);
		}	
	}

	//Coloca as caracteristicas extraidas na extrutra result
	result.max_width = max_width;
	result.max_height = max_height;
	result.max_aspect_ratio = max_width/max_height;
	result.max_perimeter = max_perimeter;
	result.max_area = max_area;	
	result.max_angle = max_angle;
	result.max_convex_hull_area = max_convex_hull_area;
	result.max_majoraxis_ellipse = max_majoraxis_ellipse;
	result.max_minoraxis_ellipse = max_minoraxis_ellipse;
	result.max_angle_ellipse = max_angle_ellipse;
	result.hu1 = max_hu.hu1;
	result.hu2 = max_hu.hu2;
	result.hu3 = max_hu.hu3;
	result.hu4 = max_hu.hu4;
	result.hu5 = max_hu.hu5;
	result.hu6 = max_hu.hu6;
	result.hu7 = max_hu.hu7;

	//Mostra a imagem resultante dos contornos
	imshow("Contours", cimage);

	return result;
}


int main(int argc, const char** argv) {
	//Imagens
	Mat image, image_gray, image_seg; 

	//Carrega a imagem do arquivo
	image = imread("frame-0039.jpg", 1); 

	//Mostra a image original
	cv::imshow("Image", image); 

	//Se a imagem foi carregada corretamente
	if(!image.empty()) {
		//Faz uma copia da imagem original 
		image_gray = image.clone(); 

		//converte a imagem para tons de cinza
		cvtColor(image, image_gray, CV_BGR2GRAY); 

		//aplica um threshold na imagem, deixando a mao em branco e fundo preto
		cv::threshold(image_gray, image_seg, 180, 255, cv::THRESH_BINARY); 

		cv::Mat kernel = cv::Mat::ones(3, 3, CV_8UC1)*255;

		//aplica uma sequencia de dilatações e erosoes para remover ruidos
		//cv::morphologyEx(image_seg, image_seg, cv::MORPH_DILATE, kernel); 
		//cv::morphologyEx(image_seg, image_seg, cv::MORPH_DILATE, kernel);
		//cv::morphologyEx(image_seg, image_seg, cv::MORPH_ERODE, kernel);
		//cv::morphologyEx(image_seg, image_seg, cv::MORPH_ERODE, kernel);

		//Mostra a image image_seg
		cv::imshow("Threshold", image_seg); 

		//Extrai as caracteristicas da imagem
		features featuresHand = ExtractStructuralFeatures(image_seg); 

		//mostra as caracteristicas no console
		printf("\n\n===========================Features==========================="); 
		printf("\n\nWidth: %f\nHeight: %f\nPerimetro: %f\nArea: %f\nAngle: %f\n", featuresHand.max_width, featuresHand.max_height, featuresHand.max_perimeter, featuresHand.max_area, featuresHand.max_angle);
		printf("Convex Hull Area: %f\nAspect Ratio: %f\nMajor Ellipse Axis: %f\nMinor Ellipse Axis: %f\nEllipse Angle: %f\n", featuresHand.max_convex_hull_area, featuresHand.max_aspect_ratio, featuresHand.max_majoraxis_ellipse, featuresHand.max_minoraxis_ellipse, featuresHand.max_angle_ellipse);
		printf("Hu1: %f\nHu2: %f\nHu3: %f\nHu4: %f\nHu5: %f\nHu6: %f\nHu7: %f\n", featuresHand.hu1, featuresHand.hu2, featuresHand.hu3, featuresHand.hu4, featuresHand.hu5, featuresHand.hu6, featuresHand.hu7);
		printf("\n==============================================================\n");

		//espera o pressionamente de uma tecla para fechar o programa
		waitKey(0);
	}
	return 0;
}