package com.tothenew.linksharing

import grails.gorm.DetachedCriteria
import groovy.transform.ToString

import org.apache.commons.lang.builder.HashCodeBuilder

@ToString(cache=true, includeNames=true, includePackage=false)
class SecUserSecRole implements Serializable {

	private static final long serialVersionUID = 1

	User user
	SecRole secRole

	SecUserSecRole(User u, SecRole r) {
		this()
		user = u
		secRole = r
	}

	@Override
	boolean equals(other) {
		if (!(other instanceof SecUserSecRole)) {
			return false
		}

		other.user?.id == user?.id && other.secRole?.id == secRole?.id
	}

	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (user) builder.append(user.id)
		if (secRole) builder.append(secRole.id)
		builder.toHashCode()
	}

	static SecUserSecRole get(long userId, long secRoleId) {
		criteriaFor(userId, secRoleId).get()
	}

	static boolean exists(long userId, long secRoleId) {
		criteriaFor(userId, secRoleId).count()
	}

	private static DetachedCriteria criteriaFor(long userId, long secRoleId) {
		SecUserSecRole.where {
			user == User.load(userId) &&
			secRole == SecRole.load(secRoleId)
		}
	}

	static SecUserSecRole create(User user, SecRole secRole, boolean flush = false) {
		def instance = new SecUserSecRole(user: user, secRole: secRole)
		instance.save(flush: true, insert: true)
		instance
	}

	static boolean remove(User u, SecRole r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = SecUserSecRole.where { user == u && secRole == r }.deleteAll()

		if (flush) { SecUserSecRole.withSession { it.flush() } }

		rowCount
	}

	static void removeAll(User u, boolean flush = false) {
		if (u == null) return

		SecUserSecRole.where { user == u }.deleteAll()

		if (flush) { SecUserSecRole.withSession { it.flush() } }
	}

	static void removeAll(SecRole r, boolean flush = false) {
		if (r == null) return

		SecUserSecRole.where { secRole == r }.deleteAll()

		if (flush) { SecUserSecRole.withSession { it.flush() } }
	}

	static constraints = {
		secRole validator: { SecRole r, SecUserSecRole ur ->
			if (ur.user == null || ur.user.id == null) return
			boolean existing = false
			SecUserSecRole.withNewSession {
				existing = SecUserSecRole.exists(ur.user.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['user', 'secRole']
		version false
	}
}
