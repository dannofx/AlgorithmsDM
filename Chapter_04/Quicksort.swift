// Example of quicksort

func quicksort<T: Comparable>(array: inout [T]) {
    sliceQuicksort(array: &array[array.startIndex..<array.endIndex])
}

func sliceQuicksort<T: Comparable>(array: inout ArraySlice<T>) {
    if array.count <= 1 {
        return
    }
    let pivot = partition(array: &array)
    sliceQuicksort(array: &(array[array.startIndex..<pivot]))
    let secondStart = pivot + 1
    if secondStart < array.endIndex {
        sliceQuicksort(array: &(array[secondStart..<array.endIndex]))
    }
    
}

func partition<T: Comparable>(array: inout ArraySlice<T>) -> Int{
    let pivot = array.endIndex - 1
    let pivotValue = array[pivot]
    var changeIndex = array.startIndex
    for i in array.startIndex..<array.endIndex {
        if array[i] < pivotValue {
            let aux = array[changeIndex]
            array[changeIndex] = array[i]
            array[i] = aux
            changeIndex += 1
        }
    }
    array[pivot] = array[changeIndex]
    array[changeIndex] = pivotValue
    return changeIndex
}