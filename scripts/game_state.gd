extends Node

# A Dictionary where the key is "RoomName_ArtifactID" and the value is boolean
var collected_artifacts: Dictionary = {}

func is_collected(artifact_key: String, artifact_data: ArtifactData) -> bool:
	return collected_artifacts.get(artifact_key, false)

func mark_as_collected(artifact_key: String, artifact_data: ArtifactData):
	collected_artifacts[artifact_key] = true
	print(collected_artifacts)
