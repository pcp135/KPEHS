from sklearn.ensemble import RandomForestClassifier
from sklearn.cross_validation import KFold
from sklearn import metrics
import pandas as pd
import numpy as np

def main():
	train = pd.read_csv('train_aa')
	train.fillna(0, inplace=True)

	train_sample = train.fillna(value=0)

	feature_names = list(train_sample.columns)
	feature_names.remove("click_bool")
	feature_names.remove("booking_bool")
	feature_names.remove("gross_bookings_usd")
	feature_names.remove("date_time")
	feature_names.remove("position")

	features = train_sample[feature_names].values
	target = train_sample["booking_bool"].values
	
	for ests in [50]:
		for feats in [30]:
	
			print("Making folds in the data")
			kf = KFold(len(features),n_folds=3,indices=False)
			classifier = [0]*3
			accuracy = [0]*3
	
			for model_num, (train, test) in enumerate(kf):

				X_train, X_test = features[train], features[test]
				Y_train, Y_test = target[train], target[test]

				classifier[model_num] = RandomForestClassifier(n_estimators=ests,
		                                        verbose=0,
		                                        n_jobs=-1,
		                                        min_samples_split=10)

				classifier[model_num].fit(X_train, Y_train)

				expected = Y_test
				predicted = classifier[model_num].predict(X_test)
				accuracy[model_num] = metrics.accuracy_score(expected, predicted)
	
				# print "Accuracy on fold %i with estimators = %i, features = %i: %f" % (
				# 	model_num+1, ests, feats, accuracy[model_num])
			print "Overall accuracy with estimators = %i, features = %i: %f" % (ests, feats,
				np.mean(accuracy))
	
if __name__=="__main__":
	main()