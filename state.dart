import 'package:flutter/material.dart';

const String kToday = '2026-09-19';
const List<String> kMon = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
const List<String> kBranches = ['Hanfi', 'Jama', 'Khwajapiya', 'Bagwanpura'];

DateTime pd(String s) => DateTime.parse('${s}T00:00:00Z');
String fd(DateTime d) => '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
String addDays(String s, int n) => fd(pd(s).add(Duration(days: n)));
int diffDays(String a, String b) => pd(a).difference(pd(b)).inDays;
String nice(String s) {
  final d = pd(s);
  return '${d.day} ${kMon[d.month - 1]} ${d.year}';
}

bool validDate(String s) {
  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(s)) return false;
  try {
    pd(s);
    return true;
  } catch (_) {
    return false;
  }
}

class Chapter {
  String title;
  int days;
  Chapter(this.title, this.days);
}

class Student {
  int id;
  String key;
  String name;
  String gender;
  int cls;
  String start;
  String parentPhone;
  String studentPhone;
  bool aadhaar;
  String address;
  String status;
  String madrasa;
  Map<int, String> done;
  Map<int, String> grade;
  List<String> absent;
  List<String> history;
  Student({
    required this.id,
    required this.key,
    required this.name,
    required this.gender,
    required this.cls,
    required this.start,
    required this.parentPhone,
    this.studentPhone = '',
    this.aadhaar = true,
    this.address = '',
    this.status = 'Active',
    this.madrasa = 'Hanfi',
    Map<int, String>? done,
    Map<int, String>? grade,
    List<String>? absent,
    List<String>? history,
  })  : done = done ?? {},
        grade = grade ?? {},
        absent = absent ?? [],
        history = history ?? [];
}

class ChapPlan {
  final String title;
  final String plan;
  final String? done;
  final String grade;
  ChapPlan(this.title, this.plan, this.done, this.grade);
}

class Prog {
  final int n;
  final int total;
  final int behind;
  final ChapPlan? next;
  Prog(this.n, this.total, this.behind, this.next);
  int get pct => total == 0 ? 0 : (n * 100 / total).round();
}

class Account {
  String phone;
  String name;
  String role;
  String roleName;
  List<String> branches;
  Account(this.phone, this.name, this.role, {this.roleName = '', List<String>? branches}) : branches = branches ?? [];
}

class Note {
  String phone;
  String text;
  Note(this.phone, this.text);
}

class Pending {
  String name;
  String gender;
  int cls;
  String parentPhone;
  bool aadhaar;
  Pending(this.name, this.gender, this.cls, this.parentPhone, this.aadhaar);
}

class Complaint {
  int id;
  String phone;
  String by;
  String to;
  String subject;
  String text;
  String status = 'Submitted';
  List<String> replies = [];
  Complaint(this.id, this.phone, this.by, this.to, this.subject, this.text);
}

class Leave {
  int id;
  String teacher;
  String type;
  String from;
  String to;
  String reason;
  String status = 'Pending';
  String remark = '';
  String by = '';
  Leave(this.id, this.teacher, this.type, this.from, this.to, this.reason);
}

class Announcement {
  String title;
  String msg;
  String priority;
  bool active = true;
  Announcement(this.title, this.msg, this.priority);
}

class ReportRow {
  final String name;
  final String period;
  final String madrasa;
  final String created;
  const ReportRow(this.name, this.period, this.madrasa, this.created);
}

String roleLabel(Account u) {
  switch (u.role) {
    case 'super':
      return 'Super Admin';
    case 'admin':
      return 'Madrasa Admin (Hanfi)';
    case 'teacher':
      return 'Teacher (Hanfi)';
    case 'parent':
      return 'Parent';
    case 'student':
      return 'Student';
    case 'committee':
      return 'Working Committee';
    default:
      return u.roleName;
  }
}

class AppState extends ChangeNotifier {
  Account? user;
  int? kidId;
  bool studentView = false;
  int nextId = 45;
  int receiptNo = 200;

  final Map<String, Account> users = {
    '9800000001': Account('9800000001', 'Faiz Raza', 'super'),
    '9800000101': Account('9800000101', 'Imam Abdul Kareem', 'admin'),
    '9800000201': Account('9800000201', 'Ustaad Salman', 'teacher'),
    '9800000301': Account('9800000301', 'Mohd Rashid', 'parent'),
    '9800000302': Account('9800000302', 'Shabana Bano', 'parent'),
    '9800000401': Account('9800000401', 'Zainab Rashid', 'student'),
    '9800000501': Account('9800000501', 'Fatima Bibi', 'custom', roleName: 'Accountant', branches: ['Hanfi']),
    '9800000601': Account('9800000601', 'Haji Anwar Khan', 'committee', branches: ['Hanfi', 'Jama']),
  };

  final Map<String, Set<String>> customRoles = {
    'Accountant': {'Fees', 'Reports'},
  };

  final Map<int, List<Chapter>> chapters = {
    1: [Chapter('Huroof-e-Mufradat', 30), Chapter('Huroof-e-Murakkabat', 30), Chapter('Harakaat', 30), Chapter('Tanween and Tashdeed', 30)],
    2: [Chapter('Amma Para reading', 45), Chapter('Basic Tajweed rules', 45)],
  };
  final Map<int, String> classNames = {1: 'Class 1 Qaida', 2: 'Class 2 Nazra'};

  final List<Student> students = [
    Student(id: 41, key: 'HNF-2026-0041', name: 'Ahmed Rashid', gender: 'Male', cls: 1, start: '2026-06-05', parentPhone: '9800000301', done: {0: '2026-07-03', 1: '2026-08-01'}, grade: {0: 'Good', 1: 'Good'}, absent: ['2026-09-12', '2026-09-15']),
    Student(id: 42, key: 'HNF-2026-0042', name: 'Bilal Yusuf', gender: 'Male', cls: 1, start: '2026-08-12', parentPhone: '9800000302', done: {0: '2026-09-10'}, grade: {0: 'Excellent'}),
    Student(id: 43, key: 'HNF-2026-0043', name: 'Yusuf Ali', gender: 'Male', cls: 1, start: '2026-06-05', parentPhone: '9800000303', done: {0: '2026-07-04', 1: '2026-08-03', 2: '2026-09-02'}, grade: {0: 'Good', 1: 'Good', 2: 'Excellent'}, absent: ['2026-09-08']),
    Student(id: 44, key: 'HNF-2026-0044', name: 'Zainab Rashid', gender: 'Female', cls: 2, start: '2026-08-20', parentPhone: '9800000301', studentPhone: '9800000401'),
    Student(id: 11, key: 'JAM-2026-0011', name: 'Sara Bano', gender: 'Female', cls: 1, start: '2026-07-01', parentPhone: '9800000310', madrasa: 'Jama', done: {0: '2026-07-30'}, grade: {0: 'Good'}),
  ];

  final List<Pending> pending = [
    Pending('Hamza Imran', 'Male', 1, '9800000304', true),
    Pending('Sara Imran', 'Female', 1, '9800000305', false),
  ];

  final Map<int, Set<String>> paid = {
    41: {'Jun', 'Jul', 'Aug'},
    42: {'Aug'},
    43: {'Jun', 'Jul', 'Aug', 'Sep'},
    44: {'Aug'},
    11: {'Jul', 'Aug', 'Sep'},
  };
  static const Map<String, int> monthNo = {'Jun': 6, 'Jul': 7, 'Aug': 8, 'Sep': 9};

  final Map<int, String> todayAtt = {};
  final Map<String, String> teacherAtt = {
    'Ustaad Salman': 'Not marked',
    'Ustaad Tariq': 'Present 07:02',
    'Ustaad Hasan': 'Present 07:10',
    'Ustaad Ibrahim': 'Present 07:04',
    'Ustaad Yaqoob': 'On leave',
  };
  final List<Leave> leaves = [];
  final List<Complaint> complaints = [];
  final List<Note> notes = [Note('9800000301', 'Qaida Ch2 completed for Ahmed on 1 Aug 2026')];
  final List<Announcement> announcements = [Announcement('Madrasa closed on 02-Oct-2026', 'Friday holiday for all madrasas.', 'Important')];
  final List<String> viewLog = [];
  final List<ReportRow> reports = const [
    ReportRow('Daily Student Attendance', '19-09-2026', 'All', '19-09-2026 18:00'),
    ReportRow('Teacher Attendance', '19-09-2026', 'All', '19-09-2026 18:00'),
    ReportRow('Teacher Leave', 'Sep 2026', 'All', '19-09-2026 18:00'),
    ReportRow('Monthly Fees', 'Sep 2026', 'Hanfi', '19-09-2026 18:00'),
    ReportRow('Syllabus Progress', '19-09-2026', 'All', '19-09-2026 18:00'),
    ReportRow('Results', 'Monthly Test Sep 2026', 'Hanfi', '19-09-2026 18:00'),
    ReportRow('Complaints', 'Sep 2026', 'All', '19-09-2026 18:00'),
    ReportRow('Admissions and Promotions', 'Sep 2026', 'All', '19-09-2026 18:00'),
  ];

  // ---------- login ----------
  void login(String phone) {
    user = users[phone];
    kidId = null;
    studentView = false;
    notifyListeners();
  }

  void logout() {
    user = null;
    notifyListeners();
  }

  bool get showFees => user != null && user!.role == 'parent' && !studentView;

  List<Student> kids() {
    final u = user;
    if (u == null) return [];
    if (u.role == 'student') return students.where((s) => s.studentPhone == u.phone).toList();
    return students.where((s) => s.parentPhone == u.phone).toList();
  }

  Student? currentKid() {
    final ks = kids();
    if (ks.isEmpty) return null;
    for (final k in ks) {
      if (k.id == kidId) return k;
    }
    return ks.first;
  }

  void selectKid(int id) {
    kidId = id;
    notifyListeners();
  }

  void toggleStudentView() {
    studentView = !studentView;
    notifyListeners();
  }

  String className(int c) => classNames[c] ?? 'Class $c';
  List<Student> inBranch(String b) => students.where((s) => s.madrasa == b).toList();
  List<Student> myStudents() {
    final u = user;
    if (u != null && u.role == 'super') return students;
    return inBranch('Hanfi');
  }

  // ---------- syllabus ----------
  List<ChapPlan> plan(Student s) {
    int c = 0;
    final list = <ChapPlan>[];
    final chs = chapters[s.cls] ?? [];
    for (var i = 0; i < chs.length; i++) {
      c += chs[i].days;
      list.add(ChapPlan(chs[i].title, addDays(s.start, c), s.done[i], s.grade[i] ?? ''));
    }
    return list;
  }

  Prog prog(Student s) {
    final p = plan(s);
    final n = p.where((x) => x.done != null).length;
    ChapPlan? next;
    for (final x in p) {
      if (x.done == null) {
        next = x;
        break;
      }
    }
    int behind = 0;
    if (next != null) {
      final d = diffDays(kToday, next.plan);
      if (d > 0) behind = d;
    }
    return Prog(n, p.length, behind, next);
  }

  void tick(Student s, int i, String date, String grade) {
    final d = validDate(date) ? date : kToday;
    s.done[i] = d;
    s.grade[i] = grade;
    final title = chapters[s.cls]![i].title;
    notes.add(Note(s.parentPhone, 'Chapter ${i + 1} ($title) completed for ${s.name} on ${nice(d)} · $grade'));
    notifyListeners();
  }

  void addChapter(int cls, String title, int days) {
    chapters.putIfAbsent(cls, () => <Chapter>[]).add(Chapter(title, days));
    notifyListeners();
  }

  bool eligible(Student s) {
    final p = prog(s);
    return s.status == 'Active' && p.total > 0 && p.n == p.total;
  }

  String promote(Student s) {
    final old = className(s.cls);
    s.history.add('$old: ${nice(s.start)} to ${nice(kToday)} (Passed)');
    if (chapters.containsKey(s.cls + 1)) {
      s.cls += 1;
      s.start = kToday;
      s.done = {};
      s.grade = {};
      notes.add(Note(s.parentPhone, '${s.name} passed $old and moved to ${className(s.cls)}. Certificate created.'));
      notifyListeners();
      return '${s.name} moved to ${className(s.cls)}. New syllabus starts ${nice(kToday)}.';
    }
    s.status = 'Graduated';
    notes.add(Note(s.parentPhone, '${s.name} passed $old and graduated.'));
    notifyListeners();
    return '${s.name} graduated.';
  }

  // ---------- attendance ----------
  int attPct(Student s) => ((24 - s.absent.length) * 100 / 24).round();

  void setAtt(int id, String v) {
    todayAtt[id] = v;
    notifyListeners();
  }

  int submitAtt(List<Student> list) {
    int n = 0;
    for (final s in list) {
      final v = todayAtt[s.id] ?? 'P';
      if (v == 'A') {
        if (!s.absent.contains(kToday)) s.absent.add(kToday);
        notes.add(Note(s.parentPhone, '${s.name} was absent on ${nice(kToday)}'));
        n++;
      } else {
        s.absent.remove(kToday);
      }
    }
    notifyListeners();
    return n;
  }

  void markSelf(String v) {
    final u = user;
    if (u == null) return;
    teacherAtt[u.name] = v == 'Present' ? 'Present 07:05' : 'Absent';
    notifyListeners();
  }

  // ---------- students ----------
  String? addStudent({required String name, required String gender, required int cls, required String parentPhone, String studentPhone = '', required bool aadhaar, String address = ''}) {
    if (name.trim().isEmpty) return 'Enter the student name';
    if (gender.isEmpty) return 'Select gender (Male or Female)';
    if (parentPhone.length != 10) return 'Parent mobile number is required (10 digits)';
    if (!aadhaar) return 'Aadhaar card is required';
    if (studentPhone.isNotEmpty) {
      if (studentPhone.length != 10) return 'Student mobile must be 10 digits, or leave it blank';
      if (studentPhone == parentPhone) return 'Student mobile must differ from the parent mobile';
      if (users.containsKey(studentPhone)) return 'This student mobile is already used';
    }
    final id = nextId++;
    final s = Student(id: id, key: 'HNF-2026-${id.toString().padLeft(4, '0')}', name: name.trim(), gender: gender, cls: cls, start: kToday, parentPhone: parentPhone, studentPhone: studentPhone, aadhaar: true, address: address.trim());
    students.add(s);
    users.putIfAbsent(parentPhone, () => Account(parentPhone, 'Parent', 'parent'));
    if (studentPhone.isNotEmpty) users[studentPhone] = Account(studentPhone, s.name, 'student');
    notes.add(Note(parentPhone, '${s.name} was added to Hanfi madrasa. ID ${s.key}'));
    notifyListeners();
    return null;
  }

  String approve(int i) {
    final p = pending[i];
    final err = addStudent(name: p.name, gender: p.gender, cls: p.cls, parentPhone: p.parentPhone, aadhaar: p.aadhaar);
    if (err != null) return err;
    pending.removeAt(i);
    notifyListeners();
    return '${p.name} approved and added.';
  }

  void reject(int i) {
    pending.removeAt(i);
    notifyListeners();
  }

  // ---------- fees ----------
  List<String> feeMonths(Student s) {
    final start = pd(s.start).month;
    return monthNo.keys.where((m) => monthNo[m]! >= start).toList();
  }

  bool isPaid(int id, String m) => paid[id]?.contains(m) ?? false;

  String pay(Student s, String m) {
    paid.putIfAbsent(s.id, () => <String>{}).add(m);
    receiptNo++;
    notes.add(Note(s.parentPhone, 'Fee for $m 2026 received (Rs. 200). $m is complete.'));
    notifyListeners();
    return 'Receipt R-2026-$receiptNo created. $m marked Complete for ${s.name}.';
  }

  int completeCount(String m) => inBranch('Hanfi').where((s) => feeMonths(s).contains(m) && isPaid(s.id, m)).length;
  int totalFor(String m) => inBranch('Hanfi').where((s) => feeMonths(s).contains(m)).length;

  // ---------- leave ----------
  String? applyLeave(String type, String from, String to, String reason) {
    if (!validDate(from) || !validDate(to)) return 'Enter dates as yyyy-mm-dd';
    if (reason.trim().length < 5) return 'Reason is required';
    leaves.add(Leave(leaves.length + 1, user!.name, type, from, to, reason.trim()));
    notifyListeners();
    return null;
  }

  void decideLeave(Leave l, bool ok, String remark) {
    l.status = ok ? 'Approved' : 'Rejected';
    l.remark = remark;
    l.by = user!.name;
    notifyListeners();
  }

  // ---------- complaints ----------
  void addComplaint(String to, String subject, String text) {
    complaints.add(Complaint(complaints.length + 12, user!.phone, user!.name, to, subject, text));
    notifyListeners();
  }

  void reply(Complaint c, String text) {
    if (text.trim().isEmpty) return;
    c.replies.add('${roleLabel(user!)}: ${text.trim()}');
    c.status = 'In progress';
    notes.add(Note(c.phone, 'Reply to your complaint CMP-${c.id.toString().padLeft(4, '0')}'));
    notifyListeners();
  }

  void resolve(Complaint c) {
    c.status = 'Resolved';
    notifyListeners();
  }

  // ---------- announcements ----------
  void postAnnouncement(String title, String msg, String priority) {
    announcements.add(Announcement(title, msg, priority));
    notifyListeners();
  }

  void withdraw(Announcement a) {
    a.active = false;
    notifyListeners();
  }

  // ---------- roles and committee ----------
  String? createRole(String name, Set<String> perms) {
    if (name.trim().isEmpty) return 'Enter a role name';
    if (perms.isEmpty) return 'Tick at least one screen';
    customRoles[name.trim()] = Set<String>.from(perms);
    notifyListeners();
    return null;
  }

  String? assignRole(String phone, String name, String roleName, String branch) {
    if (phone.length != 10) return 'Enter a 10-digit mobile number';
    if (name.trim().isEmpty) return 'Enter the name';
    if (!customRoles.containsKey(roleName)) return 'Choose a role';
    users[phone] = Account(phone, name.trim(), 'custom', roleName: roleName, branches: [branch]);
    notifyListeners();
    return null;
  }

  List<Account> committee() => users.values.where((u) => u.role == 'committee').toList();

  String? addCommittee(String phone, String name, List<String> branches) {
    if (phone.length != 10) return 'Enter a 10-digit mobile number';
    if (name.trim().isEmpty) return 'Enter the name';
    if (branches.isEmpty) return 'Choose at least one branch';
    users[phone] = Account(phone, name.trim(), 'committee', branches: branches);
    notifyListeners();
    return null;
  }

  void removeMember(String phone) {
    users.remove(phone);
    notifyListeners();
  }

  void logView(Student s) {
    viewLog.add('${nice(kToday)} · ${user?.name ?? ''} viewed ${s.key}');
    notifyListeners();
  }

  int avgAtt(String b) {
    final l = inBranch(b);
    if (l.isEmpty) return 0;
    int t = 0;
    for (final s in l) {
      t += attPct(s);
    }
    return (t / l.length).round();
  }

  int avgSyl(String b) {
    final l = inBranch(b);
    if (l.isEmpty) return 0;
    int t = 0;
    for (final s in l) {
      t += prog(s).pct;
    }
    return (t / l.length).round();
  }
}
