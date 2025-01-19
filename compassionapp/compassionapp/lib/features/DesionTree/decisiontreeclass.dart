class DecisionTreeNode {
  final String question;
  final Map<String, DecisionTreeNode>? options;
  final List<String>? results;

  DecisionTreeNode({
    this.options,
    this.question = '',
    this.results,
  });
}