# Maktab E Tajushshriah - Madrasa Management App (demo build)

A Flutter demo app that follows the Requirement Document v2.7. All data is kept
inside the app (no server), so it can be tested straight away. Data resets when
the app is closed.

## Get the APK (no software to install)
1. Create a free account on github.com and a new repository (private is fine).
2. Upload everything in this folder to the repository (Add file > Upload files).
   Make sure the folder `.github/workflows` is included. If it is missing, choose
   Add file > Create new file, type the name `.github/workflows/build-apk.yml`
   and paste the content of `github_workflow/build-apk.yml`.
3. Open the **Actions** tab, choose **Build APK**, press **Run workflow**
   (it also starts by itself when you upload). Wait 5 to 10 minutes.
4. Open the finished run, scroll to **Artifacts**, download **maktab-app-apk**,
   unzip it, and copy `app-release.apk` to the phone.
5. On the phone open the file and allow "Install from this source".

If the build turns red, open the failed step, copy the error text and send it
back. The code could not be compiled where it was written, so a small fix may be needed.

## Test users (OTP is always 123456)
| Number | Role |
|---|---|
| 98000 00301 | Parent (Ahmed and Zainab) |
| 98000 00302 | Parent (Bilal) |
| 98000 00401 | Student login (Zainab), Student view only |
| 98000 00201 | Teacher |
| 98000 00101 | Madrasa Admin |
| 98000 00001 | Super Admin |
| 98000 00601 | Working Committee (read-only, Hanfi and Jama) |
| 98000 00501 | Accountant (custom role: Fees and Reports only) |

## Included
Login with OTP; parent family account, child selector and Student view; separate
student login; individual syllabus progress with plan dates; student attendance
with absence alerts; teacher attendance and leave with approval; add student
(gender, parent mobile mandatory, student mobile optional, Aadhaar upload
mandatory, address optional); pass and promote; month-wise fees with month
complete; common announcement; complaints to teacher, admin or Super Admin;
reports centre; role manager with custom roles; committee members and the
read-only committee view; approvals.

## Not included yet
Real SMS/WhatsApp OTP, cloud database, push notifications, Qaida and Qur'an
reader, audio, tests and results entry, courses and certificates, chat, real
file upload and download, offline sync, Urdu and Hindi screens.
