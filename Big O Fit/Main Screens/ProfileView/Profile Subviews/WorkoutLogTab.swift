import SwiftUI

struct WorkoutLogTab: View {
    @ObservedObject var viewRouter: ViewRouter
    let workout: Workout
    @Binding var currentWorkout: Workout
    @EnvironmentObject var user: BigOFitUser
    
    var body: some View {
        
        return VStack (alignment: .center, spacing: 5) {
            HStack {
                VStack (alignment: .leading, spacing: 0) {
                    VStack (alignment: .leading) {
                        Text(workout.routine.name)
                            .font(.custom("Nunito-SemiBold", size: 20))
            
                        Text(self.workout.genCompleteTextFromDateComp())
                            .fontWeight(.medium)
                            .font(.custom("Nunito-Regular", size: 13))
                            .foregroundColor(CustomColors.darkishred)
                    }

                }
                Spacer()
                Image(workout.imageName)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .cornerRadius(45)
                    .shadow(radius: 3)

            }
            
        }
        .frame(width: Constants.screenWidth * 0.78)
        .padding(12)
        .background(Color.white)
        .clipped()
        .shadow(radius: 2, y: 1)
    }
    
}


struct WorkoutLogTab_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutLogTab(viewRouter: ViewRouter(), workout: Workout(routine: ExerciseList.sampleRoutine, dateComp: DateComponents(year: 2019, month: 8, day: 28, hour: 3, minute: 13, weekday: 6)), currentWorkout: Binding.constant(ExerciseList.sampleWorkout))
    }
}
