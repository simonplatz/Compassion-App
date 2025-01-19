import 'package:compassionapp/features/DesionTree/decisiontreeclass.dart';

class DecisionTree {
  final DecisionTreeNode root;

  DecisionTree(this.root);

  List<String> traverseTree(DecisionTreeNode node, List<String> answers) {
    List<String> results = [];
    for (String answer in answers) {
      if (node.options != null && node.options!.containsKey(answer)) {
        node = node.options![answer]!;
      } else {
        return results; 
      }
    }
    if (node.results != null) {
      results.addAll(node.results!);
    }
    return results;
  }
}