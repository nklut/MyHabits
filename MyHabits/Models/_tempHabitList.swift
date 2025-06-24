import UIKit

struct habitListItem {
    let habitLabel: String
    let habitDescription: String
    let habitCounter: String
    let HabitColor: UIColor
}

struct dateSinceInstall {
    let currentDate: Date
}

extension habitListItem {
    static func make() -> [habitListItem] {
        [
            habitListItem(
                habitLabel: "Habit 1 Check This Line is long enough to cover 3 lines of text horrayh",
                habitDescription: "Habit 1 description",
                habitCounter: "Habit 1: 3",
                HabitColor: .mhBlue),
            habitListItem(
                habitLabel: "Habit 2",
                habitDescription: "Habit 2 description",
                habitCounter: "Habit 2: 3",
                HabitColor: .mhGreen),
            habitListItem(
                habitLabel: "Habit 3",
                habitDescription: "Habit 3 description",
                habitCounter: "Habit 3: 3",
                HabitColor: .mhOrange),
            habitListItem(
                habitLabel: "Habit 4",
                habitDescription: "Habit 4 description",
                habitCounter: "Habit 4: 3",
                HabitColor: .mhPurple),
            habitListItem(
                habitLabel: "Habit 5",
                habitDescription: "Habit 5 description",
                habitCounter: "Habit 5: 3",
                HabitColor: .mhViolet),
        ]
    }
    static func addHabit(item: habitListItem, list: [habitListItem]) -> [habitListItem] {
        print("New habit item: ", item)
        var newList: [habitListItem] = list
        newList.append(item)
        print("New habit List: ", newList)
        return newList
    }
}

var habitsList: [habitListItem] = habitListItem.make()

//var habitsAllDates: [Date] = HabitsStore.shared.dates

var habitsAllDates: [Date] = [
    Date.now,
    Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!,
    Calendar.current.date(byAdding: .day, value: 2, to: Date.now)!,
    Calendar.current.date(byAdding: .day, value: 3, to: Date.now)!,
]
