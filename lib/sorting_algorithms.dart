void main() {
  selection([10, 2, 13, 17, 7]);
}

Stream<List<int>> selection(List<int> list) async* {
  List<int> clonedList = List.from(list);

  int listLength = clonedList.length;
  for (int i = 0; i < listLength - 1; i++) {
    int min = i;
    for (int j = i + 1; j < listLength; j++) {
      if (clonedList[j] < clonedList[min]) {
        min = j;
      }
    }
    if (min != i) {
      int temp = clonedList[i];
      clonedList[i] = clonedList[min];
      clonedList[min] = temp;
      yield List<int>.from(clonedList);
    }
  }
}

Stream<List<int>> bubble(List<int> list) async* {
  List<int> clonedList = List.from(list);

  int n = clonedList.length;
  for (int i = 0; i < n - 1; i++) {
    for (int j = 0; j < n - i - 1; j++) {
      if (clonedList[j] > clonedList[j + 1]) {
        int temp = clonedList[j];
        clonedList[j] = clonedList[j + 1];
        clonedList[j + 1] = temp;

        yield List<int>.from(clonedList);
      }
    }
  }
}

Stream<List<int>> insertion(List<int> list) async* {
  List<int> clonedList = List.from(list);

  int listLength = clonedList.length;
  for (int i = 1; i < listLength; i++) {
    int key = clonedList[i];
    int j = i - 1;
    while (j >= 0 && clonedList[j] > key) {
      clonedList[j + 1] = clonedList[j];
      j = j - 1;
      yield List<int>.from(clonedList);
    }
    clonedList[j + 1] = key;

    yield List<int>.from(clonedList);
  }
}

Stream<List<int>> quick(List<int> list, {int low = 0, int? high}) async* {
  high ??= list.length - 1;
  if (low < high) {
    int pivot = list[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
      if (list[j] <= pivot) {
        i++;
        int temp = list[i];
        list[i] = list[j];
        list[j] = temp;
        yield List<int>.from(list);
      }
    }
    int temp = list[i + 1];
    list[i + 1] = list[high];
    list[high] = temp;
    int pivotIndex = i + 1;
    yield List<int>.from(list);

    yield* quick(list, low: low, high: pivotIndex - 1);
    yield* quick(list, low: pivotIndex + 1, high: high);
  }
}

Stream<List<int>> mergeSort(List<int> numbers) async* {
  if (numbers.length <= 1) {
    yield List<int>.from(numbers);
    return;
  }

  List<int> result = List.from(numbers);
  List<int> temp = List.filled(numbers.length, 0);

  for (int size = 1; size < numbers.length; size *= 2) {
    for (int leftStart = 0;
        leftStart < numbers.length - 1;
        leftStart += 2 * size) {
      int mid = leftStart + size - 1;
      int rightEnd = (leftStart + 2 * size - 1).clamp(0, numbers.length - 1);

      merge(result, temp, leftStart, mid, rightEnd);

      yield List<int>.from(result);
      await Future.delayed(const Duration(
          milliseconds: 100)); // introduce a delay before the next step
    }
  }
}

void merge(
    List<int> result, List<int> temp, int leftStart, int mid, int rightEnd) {
  int leftEnd = mid;
  int rightStart = mid + 1;

  int size = rightEnd - leftStart + 1;

  int leftIndex = leftStart;
  int rightIndex = rightStart;
  int tempIndex = 0;

  while (leftIndex <= leftEnd && rightIndex <= rightEnd) {
    if (result[leftIndex] <= result[rightIndex]) {
      temp[tempIndex++] = result[leftIndex++];
    } else {
      temp[tempIndex++] = result[rightIndex++];
    }
  }

  while (leftIndex <= leftEnd) {
    temp[tempIndex++] = result[leftIndex++];
  }

  while (rightIndex <= rightEnd) {
    temp[tempIndex++] = result[rightIndex++];
  }

  for (int i = 0; i < size; i++) {
    result[leftStart + i] = temp[i];
  }
}

bool isSorted(List<int> list) {
  for (int i = 0; i < list.length - 1; i++) {
    if (list[i] > list[i + 1]) {
      return false;
    }
  }
  return true;
}

Stream<List<int>> bogo(List<int> list) async* {
  List<int> clonedList = List.from(list);

  while (!isSorted(clonedList)) {
    clonedList.shuffle();
    yield List<int>.from(clonedList);
  }

  yield List<int>.from(clonedList);
}

Stream<List<int>> heap(List<int> arr) async* {
  List<int> clonedArr = List.from(arr);

  void heapify(List<int> arr, int n, int i) {
    int largest = i;
    int leftChild = 2 * i + 1;
    int rightChild = 2 * i + 2;

    if (leftChild < n && arr[leftChild] > arr[largest]) {
      largest = leftChild;
    }

    if (rightChild < n && arr[rightChild] > arr[largest]) {
      largest = rightChild;
    }

    if (largest != i) {
      int temp = arr[i];
      arr[i] = arr[largest];
      arr[largest] = temp;

      heapify(arr, n, largest);
    }
  }

  int n = clonedArr.length;

  for (int i = (n ~/ 2) - 1; i >= 0; i--) {
    heapify(clonedArr, n, i);
    yield List<int>.from(clonedArr);
  }

  for (int i = n - 1; i > 0; i--) {
    int temp = clonedArr[0];
    clonedArr[0] = clonedArr[i];
    clonedArr[i] = temp;

    heapify(clonedArr, i, 0);
    yield List<int>.from(clonedArr);
  }

  yield List<int>.from(clonedArr);
}

Stream<List<int>> shell(List<int> arr) async* {
  List<int> clonedArr = List.from(arr);
  int n = clonedArr.length;

  for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
    for (int i = gap; i < n; i++) {
      int temp = clonedArr[i];
      int j = i;

      while (j >= gap && clonedArr[j - gap] > temp) {
        clonedArr[j] = clonedArr[j - gap];
        j -= gap;
        yield List<int>.from(clonedArr);
      }

      clonedArr[j] = temp;
      yield List<int>.from(clonedArr);
    }
  }
}
