import 'package:db_uicomponents/db_uicomponents.dart';
import 'package:dkb_retail/core/constants/asset_path/asset_path.dart';
import 'package:flutter/material.dart';

import '../../data/model/account_summary_model.dart';

class AccountTile extends StatefulWidget {
  final AccountDetailsA account;
  const AccountTile({super.key, required this.account});

  @override
  State<AccountTile> createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  bool _isBalanceVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: DefaultColors.white_0,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiTextNew.h5Regular(
                widget.account.accountType,
                color: DefaultColors.white_800,
              ),
              // SizedBox(height: 8),
              Row(
                children: [
                  UiTextNew.h5Regular(
                    '${widget.account.currencyName} ',
                    color: DefaultColors.gray8A,
                  ),
                  UiTextNew.customRubik(
                    _isBalanceVisible
                        ? widget.account.availableBal
                        : '********',
                    color: DefaultColors.blue9D,
                    fontSize: 18,
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: _toggleVisibility,
            child: UISvgIcon(
              assetPath: _isBalanceVisible
                  ? AssetPath.icon.retailVisibilityIcon
                  : AssetPath.icon.retailVisibilityOffIcon,
              color: DefaultColors.blue9D,
              // color: _isBalanceVisible ? DefaultColors.white_800 : DefaultColors.blue88,
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
