import 'package:flutter/material.dart';
import '../../../data/models/branch_model.dart';
import 'branch_card.dart';

class BranchesPanelWidget extends StatefulWidget {
  final VoidCallback onClose;
  final List<BranchModel> branches;
  final Function(BranchModel) onSelectBranch;

  const BranchesPanelWidget({
    super.key,
    required this.onClose,
    required this.branches,
    required this.onSelectBranch,
  });

  @override
  State<BranchesPanelWidget> createState() => _BranchesPanelWidgetState();
}

class _BranchesPanelWidgetState extends State<BranchesPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 255,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.52),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 18,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 8, 8),
            child: Row(
              children: [
                const Icon(Icons.store_mall_directory,
                    size: 18, color: Color(0xFF4CAF50)),
                const SizedBox(width: 7),
                Text('Our Branches',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900])),
                const Spacer(),
                GestureDetector(
                  onTap: widget.onClose,
                  child: const Icon(Icons.close, size: 17, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: widget.branches.length,
              itemBuilder: (_, i) => BranchCardWidget(
                branch: widget.branches[i],
                onTap: () => widget.onSelectBranch(widget.branches[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
