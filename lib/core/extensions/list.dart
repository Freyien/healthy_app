extension ListExtensions on List {
  List<T> replaceAt<T>(int index, T item) {
    List<T> cloneList = [...this];
    cloneList.replaceRange(index, index + 1, [item]);

    return cloneList;
  }
}
