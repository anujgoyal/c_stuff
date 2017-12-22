// https://leetcode.com/problems/invert-binary-tree/description/
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *   int val;
 *   TreeNode *left;
 *   TreeNode *right;
 *   TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    TreeNode* invertTree(TreeNode* root) {
        if (NULL==left && NULL==right) return;
        TreeNode *temp = right;
        right=left;
        left=temp;
        if(left) invertTree (left);
        if(right) invertTree (right);
    }
};
