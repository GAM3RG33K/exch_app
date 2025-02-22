# Production Release Checklist - Android & iOS

## Android

- [X] 1.  **Review Play Store Listing:** Ensure all details (title, description, screenshots, etc.) are accurate and up-to-date.
- [X] 2.  **App Icon:** Verify the app icon is correctly configured and displayed in all required sizes.
- [X] 3.  **Version Code & Version Name:** Increment the `versionCode` (integer) and `versionName` (string) in `pubspec.yaml`. The `versionCode` MUST be higher than any previous release.
- [X] 4.  **Build Configuration:** Build the app in release mode (`flutter build appbundle` or `flutter build apk --release`). Ensure you are using the correct build variants if you have them (e.g., different flavors).
- [X] 5.  **Signing:** Sign the app with your release key. This usually involves configuring signing in `android/app/build.gradle` and providing your keystore.
- [X] 6.  **Testing:** Thoroughly test the release build on various devices and Android versions. Test on physical devices, not just emulators.
- [X] 7.  **App Bundle/APK:** Generate the release App Bundle (AAB, preferred) or APK.
- [ ] 8.  **Internal Testing Track (Recommended):** Upload the AAB/APK to the internal testing track on the Play Console first. This allows you to test with a limited group before wider release.
- [ ] 9.  **Closed/Open Testing Tracks (Optional):** Consider using closed or open testing tracks for broader beta testing.
- [ ] 10. **Production Release:** Once testing is complete, promote the app to production.
- [ ] 11. **Monitor Crash Reports & Reviews:** After release, closely monitor crash reports and user reviews in the Play Console.

## iOS

- [ ] 1.  **Review App Store Connect Information:** Ensure all details (name, description, screenshots, keywords, etc.) are accurate and up-to-date.
- [ ] 2.  **App Icon & Launch Screen:** Verify the app icon and launch screen are correctly configured and displayed in all required sizes and resolutions.
- [ ] 3.  **Version & Build Number:** Increment the `CFBundleShortVersionString` (version) and `CFBundleVersion` (build number) in `ios/Runner/Info.plist`. The build number MUST be higher than any previous release.
- [ ] 4.  **Build Configuration:** Build the app in release mode (`flutter build ios --release`). Ensure you are using the correct build configuration (e.g., Release, Debug).
- [ ] 5.  **Code Signing:** Ensure your app is correctly code-signed with your distribution certificate and provisioning profile. This is managed in Xcode.
- [ ] 6.  **Provisioning Profile:** Use a distribution provisioning profile for your release build. This profile links your app, your developer account, and the devices allowed to run the app.
- [ ] 7.  **Testing:** Thoroughly test the release build on various devices and iOS versions. Test on physical devices, not just simulators. Use TestFlight for beta testing.
- [ ] 8.  **Archive:** Create an archive of your app in Xcode (Product > Archive).
- [ ] 9.  **Upload to App Store Connect:** Upload the archive to App Store Connect through Xcode (Organizer window) or Transporter.
- [ ] 10. **TestFlight (Recommended):** Distribute your app to beta testers via TestFlight before releasing to the public.
- [ ] 11. **Submit for Review:** Once testing is complete, submit your app for review by Apple.
- [ ] 12. **Release:** After your app is approved, you can release it to the App Store.
- [ ] 13. **Monitor Crash Reports & Reviews:** After release, closely monitor crash reports and user reviews in App Store Connect.

## General

- [ ] 1.  **Privacy Policy:** Ensure your app has a privacy policy, and it's linked in your store listing (both Play Store and App Store Connect).
- [ ] 2.  **Terms of Service (If Applicable):** If your app requires terms of service, ensure they are available and linked appropriately.
- [ ] 3.  **Third-Party Libraries:** Review and update any third-party libraries used in your app. Check for security vulnerabilities and compatibility.
- [ ] 4.  **Backend Services:** Ensure your backend services (if any) are ready for production load and are properly scaled.
- [ ] 5.  **Analytics:** Verify your analytics integration is working correctly and collecting data.
- [ ] 6.  **Feature Flags (Optional):** If you use feature flags, ensure they are set correctly for the production release.
- [ ] 7.  **Documentation:** Update any relevant documentation for your app (user guides, API documentation, etc.).
- [x] 8.  **Verify Checklist:** Verify all items on this checklist are complete. (Marked as done)

## Additional Requirements
**Category**:  
`Finance` > `Currency Converter`

**Contact Information**:  
- Developer: Harshvardhan Joshi  
- Email: [harsh@harshjoshi.dev](mailto:harsh@harshjoshi.dev)  
- Website: [harshjoshi.dev](https://harshjoshi.dev)

**Privacy Policy**:  
- Current link: `https://harshjoshi.dev/privacy` (from README.md)
- Verify GDPR compliance and data collection disclosures

**Recent Changes**:  