package com.example.db_uicomponents;

import java.net.NetworkInterface;
import java.util.Collections;

public class Utils {
    public static boolean isCurrentStateVPN() {
        boolean isConnectionActive = false;
        try {
            String avlIntf = "";
            for (NetworkInterface intfVpn : Collections.<NetworkInterface>list(NetworkInterface.getNetworkInterfaces())) {
                if (intfVpn.isUp()) {
                    avlIntf = intfVpn.getName();
                    if (avlIntf.contains("tun") || avlIntf.contains("tap") || avlIntf.contains("ppp") || avlIntf.contains("ipsec") || avlIntf.contains("utun") || avlIntf.contains("pptp")) {
                        isConnectionActive = true;
                    }
                }
            }
        } catch (Exception e) {
            return isConnectionActive;
        }
        return isConnectionActive;
    }
}