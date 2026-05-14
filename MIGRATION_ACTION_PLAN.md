# 🎯 Supabase Migration - Action Plan

## ✅ COMPLETED SO FAR

### Phase 1 & 2: Core Systems (100%)
- ✅ Real authentication with Supabase
- ✅ Real profile setup with database persistence
- ✅ ProfileScreen migrated to real data
- ✅ Logout functionality implemented

---

## 🚀 NEXT ACTIONS (Priority Order)

### IMMEDIATE: Complete Phase 3 - Presentation Layer

#### Action 1: Migrate Remaining Screens (4-6 hours)

**1.1 OffersScreen** (1 hour)
```dart
// Create provider
@riverpod
Future<Map<String, List<Offer>>> myOffers(MyOffersRef ref) async {
  return await ref.watch(offersRepositoryProvider).getMyOffers();
}

// Update screen to use provider
final offersAsync = ref.watch(myOffersProvider);
```

**1.2 MyMatchesScreen** (1 hour)
```dart
// Create provider
@riverpod
Future<List<Participation>> myParticipations(MyParticipationsRef ref) async {
  return await ref.watch(participationsRepositoryProvider).getMyParticipations();
}

// Update screen to use provider
final participationsAsync = ref.watch(myParticipationsProvider);
```

**1.3 MessagesListScreen** (1.5 hours)
```dart
// Create provider with realtime
@riverpod
Stream<List<Chat>> myChats(MyChatsRef ref) {
  return ref.watch(chatsRepositoryProvider).getMyChatsStream();
}

// Update screen to use stream provider
final chatsAsync = ref.watch(myChatsProvider);
```

**1.4 MatchListingDetailScreen** (1.5 hours)
```dart
// Create provider
@riverpod
Future<MatchListing> matchListingDetail(
  MatchListingDetailRef ref,
  String matchId,
) async {
  return await ref.watch(matchListingsRepositoryProvider).getOne(matchId);
}

// Update screen to use provider
final matchAsync = ref.watch(matchListingDetailProvider(matchId));
```

**1.5 UserProfileScreen** (1 hour)
```dart
// Create provider
@riverpod
Future<User> userProfile(UserProfileRef ref, String userId) async {
  return await ref.watch(usersRepositoryProvider).getUserById(userId);
}

// Update screen to use provider
final userAsync = ref.watch(userProfileProvider(userId));
```

---

### NEXT: Phase 4 - Critical Features (8-12 hours)

#### Action 2: Implement Core Features

**2.1 Match Join Functionality** (2 hours)
- Add join button to MatchListingDetailScreen
- Create application via ApplicationsRepository
- Show success/error feedback
- Refresh match data after join

**2.2 Offer Accept/Reject** (2 hours)
- Add accept/reject buttons to OffersScreen
- Update offer status via OffersRepository
- Show success/error feedback
- Refresh offers list

**2.3 Chat Detail Screen** (3 hours)
- Create ChatDetailScreen
- Connect to ChatsRepository
- Implement realtime message updates
- Add message sending functionality
- Add message input UI

**2.4 Notifications Screen** (2 hours)
- Create NotificationsScreen
- Connect to notifications table
- Implement realtime updates
- Add mark as read functionality

**2.5 Basic Settings Screens** (1 hour)
- Create placeholder settings screens
- Add navigation from ProfileScreen
- Basic UI structure

---

### THEN: Phase 5 - Testing & Polish (4-6 hours)

#### Action 3: End-to-End Testing

**3.1 Critical User Flows** (2 hours)
- [ ] Signup → Profile Setup → Explore
- [ ] Login → Dashboard → Profile
- [ ] Create Match → View Applications
- [ ] Join Match → View My Matches
- [ ] Send Offer → Accept/Reject
- [ ] Send Message → Receive Reply

**3.2 Error Scenarios** (1 hour)
- [ ] Network errors
- [ ] Auth errors
- [ ] Validation errors
- [ ] Empty states
- [ ] Loading states

**3.3 Edge Cases** (1 hour)
- [ ] No internet connection
- [ ] Session expiry
- [ ] Concurrent updates
- [ ] Large data sets

**3.4 Performance** (1 hour)
- [ ] List scrolling performance
- [ ] Image loading
- [ ] Realtime updates
- [ ] Memory usage

---

## 📋 DETAILED TASK BREAKDOWN

### Week 1: Complete Presentation Migration

#### Day 1-2: Migrate Screens
- [ ] Create providers for all screens
- [ ] Update screens to use providers
- [ ] Remove all mock data
- [ ] Add loading states
- [ ] Add error states
- [ ] Test each screen individually

#### Day 3: Implement Core Features
- [ ] Match join functionality
- [ ] Offer accept/reject
- [ ] Basic chat screen

#### Day 4: Notifications & Settings
- [ ] Notifications screen
- [ ] Settings screens structure
- [ ] Navigation updates

#### Day 5: Testing & Bug Fixes
- [ ] End-to-end testing
- [ ] Fix discovered bugs
- [ ] Polish UI/UX
- [ ] Performance optimization

---

## 🛠️ IMPLEMENTATION TEMPLATES

### Template 1: Simple List Screen Migration

```dart
// 1. Create provider file
// lib/features/[feature]/application/[feature]_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/repositories/[repository].dart';

part '[feature]_provider.g.dart';

@riverpod
Future<List<Model>> [featureName]([FeatureName]Ref ref) async {
  return await ref.watch([repository]Provider).[method]();
}

// 2. Update screen
class [Feature]Screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch([featureName]Provider);
    
    return dataAsync.when(
      data: (items) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}

// 3. Run code generation
// dart run build_runner build --delete-conflicting-outputs
```

### Template 2: Detail Screen with Parameter

```dart
// 1. Create provider with parameter
@riverpod
Future<Model> [featureName](
  [FeatureName]Ref ref,
  String id,
) async {
  return await ref.watch([repository]Provider).getOne(id);
}

// 2. Update screen
class [Feature]DetailScreen extends ConsumerWidget {
  final String id;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch([featureName]Provider(id));
    
    return dataAsync.when(
      data: (item) => DetailView(item),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

### Template 3: Realtime Stream Screen

```dart
// 1. Create stream provider
@riverpod
Stream<List<Model>> [featureName]([FeatureName]Ref ref) {
  return ref.watch([repository]Provider).[streamMethod]();
}

// 2. Update screen (same as Future, Riverpod handles streams)
final dataAsync = ref.watch([featureName]Provider);
```

---

## 🎯 SUCCESS METRICS

### Phase 3 Complete When:
- [ ] All 6 screens migrated
- [ ] Zero mock data in presentation layer
- [ ] All screens show loading states
- [ ] All screens show error states
- [ ] All screens show empty states
- [ ] Code generation successful
- [ ] No TypeScript/Dart errors

### Phase 4 Complete When:
- [ ] Users can join matches
- [ ] Users can accept/reject offers
- [ ] Users can send/receive messages
- [ ] Users can view notifications
- [ ] Settings screens accessible

### Phase 5 Complete When:
- [ ] All critical flows tested
- [ ] All error scenarios handled
- [ ] Performance acceptable
- [ ] No console errors
- [ ] Ready for production

---

## 🚨 BLOCKERS & RISKS

### Potential Blockers
1. **Missing RPC functions** - Some queries may need database functions
2. **Realtime permissions** - RLS policies may block realtime subscriptions
3. **Storage permissions** - Avatar uploads may fail without proper policies
4. **Type mismatches** - Database types may not match Dart models

### Mitigation Strategies
1. Check Supabase Dashboard for RPC functions
2. Review RLS policies in migration file
3. Test storage upload in isolation
4. Regenerate types from database schema

---

## 📞 HELP & RESOURCES

### When Stuck
1. Check `MIGRATION_REPORT.md` for context
2. Check `SUPABASE_SETUP.md` for configuration
3. Check repository implementations for examples
4. Check Supabase Dashboard for data/errors

### Code Generation Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Supabase Connection Issues
```bash
# Test connection
# Uncomment in main.dart:
await SupabaseTest.runAllTests();
```

---

## ✅ COMPLETION CHECKLIST

### Before Marking Phase 3 Complete
- [ ] All 6 screens migrated
- [ ] All providers created and generated
- [ ] All mock data removed
- [ ] All screens tested manually
- [ ] Code generation successful
- [ ] No compilation errors
- [ ] Loading states working
- [ ] Error states working
- [ ] Empty states working

### Before Marking Phase 4 Complete
- [ ] Match join working
- [ ] Offer accept/reject working
- [ ] Chat sending working
- [ ] Notifications displaying
- [ ] Settings accessible

### Before Marking Phase 5 Complete
- [ ] All user flows tested
- [ ] All error scenarios tested
- [ ] Performance acceptable
- [ ] Security reviewed
- [ ] Ready for production

---

**Start Date:** May 12, 2026  
**Target Completion:** May 19, 2026 (1 week)  
**Current Status:** Phase 3 - 20% Complete

**Next Action:** Migrate OffersScreen (1 hour)
