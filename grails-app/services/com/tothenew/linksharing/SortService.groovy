package com.tothenew.linksharing

import grails.transaction.Transactional

@Transactional
class SortService {

    def bubSort(List testArray, List idArray) {
        for (int i = 0; i < testArray.size() - 1; i++) {
            def temp;
            for (int j = 0; j < testArray.size() - i - 1; j++) {
                if (testArray[j] > testArray[j + 1]) {
                    temp = testArray[j];
                    testArray[j] = testArray[j + 1]
                    testArray[j + 1] = temp

                    temp = idArray[j];
                    idArray[j] = idArray[j + 1]
                    idArray[j + 1] = temp

                    println "================="+idArray
                }
            }
        }


        return idArray
    }

/*********Quick Sort implemented***************/

    def partition(List testArray, int low, int high, List idArray) {
        int pivot = testArray[high]
        int i = low - 1; // index of smaller element
        for (int j = low; j <= high - 1; j++) {
            if (testArray[j] <= pivot) {
                i++;

                int temp = testArray[i];
                testArray[i] = testArray[j];
                testArray[j] = temp;

                temp = idArray[i];
                idArray[i] = idArray[j];
                idArray[j] = temp;
            }
        }

        int temp = testArray[i + 1];
        testArray[i + 1] = testArray[high];
        testArray[high] = temp;

        temp = idArray[i + 1];
        idArray[i + 1] = idArray[high];
        idArray[high] = temp;

        println "---------------------------"+idArray
        return i + 1;
    }

    def qSort(List testArray, int low, int high, List idArray) {
        if (low < high) {
            int pi = partition(testArray, low, high, idArray);

            qSort(testArray, low, pi - 1, idArray);
            qSort(testArray, pi + 1, high, idArray);
        }
        return idArray
    }
/***********QUICK SORT ENDS********/

}